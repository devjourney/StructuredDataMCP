"""StructuredDataMCP - Data-driven SQLite query MCP server."""

import asyncio
from pathlib import Path
from fastmcp import FastMCP
from src.structureddatamcp.loader import QueryLoader
from src.structureddatamcp.validator import SQLValidator
from src.structureddatamcp.executor import QueryExecutor
from src.structureddatamcp.factory import ToolFactory


# Initialize server
mcp = FastMCP("StructuredDataMCP")

# Configuration paths
PROJECT_ROOT = Path(__file__).parent
CONFIG_DIR = PROJECT_ROOT / "config"


async def initialize_tools():
    """Load query definitions and register tools on startup."""
    import sys

    # Load server settings
    loader = QueryLoader(CONFIG_DIR)
    settings = loader.load_settings()

    # Set up SQL validator
    validator = SQLValidator(
        allowed_statements=settings.security.allowed_statements
    )

    # Set up query executor
    db_path = PROJECT_ROOT / settings.database.path
    executor = QueryExecutor(
        db_path=db_path,
        validator=validator,
        max_results=settings.security.max_results,
        query_timeout=settings.security.query_timeout
    )

    # Create tool factory
    factory = ToolFactory(executor)

    # Load all query definitions and create tools
    tool_count = 0
    for query_def in loader.load_all_queries():
        tool = factory.create_tool(query_def)
        mcp.add_tool(tool)
        tool_count += 1

    # Write to stderr to avoid corrupting MCP protocol on stdout
    print(f"✓ Loaded {tool_count} query tools from {CONFIG_DIR / 'queries'}", file=sys.stderr)
    print(f"✓ Database: {db_path}", file=sys.stderr)
    print(f"✓ Server: {settings.server.name} v{settings.server.version}", file=sys.stderr)


if __name__ == "__main__":
    # Initialize tools before starting server
    asyncio.run(initialize_tools())

    # Run the server
    mcp.run()
