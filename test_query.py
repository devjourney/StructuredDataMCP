#!/usr/bin/env python3
"""Test script to debug query execution."""

import asyncio
import sys
from pathlib import Path

# Add src to path
sys.path.insert(0, str(Path(__file__).parent))

from src.structureddatamcp.loader import QueryLoader
from src.structureddatamcp.validator import SQLValidator
from src.structureddatamcp.executor import QueryExecutor


async def test_query():
    """Test executing a query directly."""
    try:
        # Set up paths
        PROJECT_ROOT = Path(__file__).parent
        CONFIG_DIR = PROJECT_ROOT / "config"

        # Load settings
        loader = QueryLoader(CONFIG_DIR)
        settings = loader.load_settings()

        # Create validator
        validator = SQLValidator(
            allowed_statements=settings.security.allowed_statements
        )

        # Create executor
        db_path = PROJECT_ROOT / settings.database.path
        print(f"Database path: {db_path}")
        print(f"Database exists: {db_path.exists()}")

        executor = QueryExecutor(
            db_path=db_path,
            validator=validator,
            max_results=settings.security.max_results,
            query_timeout=settings.security.query_timeout
        )

        # Load a query definition
        queries = list(loader.load_all_queries())
        print(f"\nLoaded {len(queries)} queries")

        # Test the first query
        query_def = queries[0]
        print(f"\nTesting query: {query_def.name}")
        print(f"SQL: {query_def.sql[:100]}...")
        print(f"Parameters: {[p.name for p in query_def.parameters]}")

        # Build test arguments
        arguments = {}
        for param in query_def.parameters:
            if param.required and param.default is None:
                # Provide a test value for required parameters
                if param.type == "integer":
                    arguments[param.name] = 1
                elif param.type == "string":
                    arguments[param.name] = "test"
                elif param.type == "boolean":
                    arguments[param.name] = True
                elif param.type == "number":
                    arguments[param.name] = 1.0
            elif param.default is not None:
                arguments[param.name] = param.default

        print(f"Arguments: {arguments}")

        # Execute query
        print("\nExecuting query...")
        result = await executor.execute_query(query_def, arguments)

        print("\nResult:")
        print(f"Count: {result['count']}")
        print(f"Results: {result['results'][:2] if result['results'] else []}")  # Show first 2
        print("\n✓ Query executed successfully!")

    except Exception as e:
        print(f"\n✗ Error: {type(e).__name__}: {e}")
        import traceback
        traceback.print_exc()
        return 1

    return 0


if __name__ == "__main__":
    sys.exit(asyncio.run(test_query()))
