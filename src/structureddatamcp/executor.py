"""Async SQLite query executor with safety checks."""

import aiosqlite
from pathlib import Path
from typing import Any
from contextlib import asynccontextmanager
from .models import QueryDefinition, QueryParameter
from .validator import SQLValidator


class QueryExecutor:
    """Executes SQL queries with parameterization and safety checks."""

    def __init__(
        self,
        db_path: Path,
        validator: SQLValidator,
        max_results: int = 1000,
        query_timeout: int = 30
    ):
        """
        Initialize query executor.

        Args:
            db_path: Path to SQLite database
            validator: SQL validator instance
            max_results: Maximum rows to return
            query_timeout: Query execution timeout in seconds
        """
        self.db_path = Path(db_path)
        self.validator = validator
        self.max_results = max_results
        self.query_timeout = query_timeout

        if not self.db_path.exists():
            raise FileNotFoundError(f"Database not found: {db_path}")

    @asynccontextmanager
    async def get_connection(self):
        """Get a read-only database connection."""
        # Open in read-only mode for safety
        # uri=True enables URI filename interpretation
        # mode=ro ensures read-only access
        uri = f"file:{self.db_path}?mode=ro"

        async with aiosqlite.connect(uri, uri=True, timeout=self.query_timeout) as conn:
            # Enable read-only mode at SQLite level
            await conn.execute("PRAGMA query_only = ON")

            # Row factory to get dict-like results
            conn.row_factory = aiosqlite.Row

            yield conn

    async def execute_query(
        self,
        query_def: QueryDefinition,
        arguments: dict[str, Any]
    ) -> dict[str, Any]:
        """
        Execute a query with provided arguments.

        Args:
            query_def: Query definition from YAML
            arguments: Parameter values from MCP tool call

        Returns:
            Query results as structured dict matching output_schema

        Raises:
            ValueError: If validation fails
            RuntimeError: If query execution fails
        """
        # Validate SQL
        is_valid, error = self.validator.validate(query_def.sql)
        if not is_valid:
            raise ValueError(f"SQL validation failed: {error}")

        # Validate parameters
        defined_params = [p.name for p in query_def.parameters]
        is_valid, error = self.validator.validate_parameters(query_def.sql, defined_params)
        if not is_valid:
            raise ValueError(f"Parameter validation failed: {error}")

        # Process and validate arguments
        processed_args = self._process_arguments(query_def.parameters, arguments)

        # Execute query
        try:
            async with self.get_connection() as conn:
                cursor = await conn.execute(query_def.sql, processed_args)

                # Fetch results with limit
                rows = await cursor.fetchmany(self.max_results + 1)

                # Check if results exceeded limit
                if len(rows) > self.max_results:
                    raise RuntimeError(
                        f"Query returned more than {self.max_results} rows. "
                        "Please add more specific filters."
                    )

                # Convert rows to dicts
                result_list = [dict(row) for row in rows]

                # Always return consistent format: {"results": [...], "count": N}
                return {
                    'results': result_list,
                    'count': len(result_list)
                }

        except aiosqlite.Error as e:
            raise RuntimeError(f"Database error: {str(e)}") from e

    def _process_arguments(
        self,
        param_defs: list[QueryParameter],
        arguments: dict[str, Any]
    ) -> dict[str, Any]:
        """
        Process and validate query arguments.

        Args:
            param_defs: Parameter definitions from query
            arguments: Raw arguments from tool call

        Returns:
            Processed arguments dict with defaults applied

        Raises:
            ValueError: If validation fails
        """
        processed = {}

        for param_def in param_defs:
            value = arguments.get(param_def.name)

            # Check required parameters
            if value is None:
                if param_def.required and param_def.default is None:
                    raise ValueError(f"Required parameter '{param_def.name}' missing")
                value = param_def.default

            # Apply type coercion and validation
            if value is not None:
                value = self._validate_and_coerce(param_def, value)

            processed[param_def.name] = value

        return processed

    def _validate_and_coerce(self, param_def: QueryParameter, value: Any) -> Any:
        """Validate and coerce parameter value to correct type."""
        # Type coercion
        try:
            if param_def.type == "integer":
                value = int(value)
            elif param_def.type == "number":
                value = float(value)
            elif param_def.type == "boolean":
                value = bool(value)
            elif param_def.type == "string":
                value = str(value)
        except (ValueError, TypeError) as e:
            raise ValueError(
                f"Parameter '{param_def.name}' must be {param_def.type}, got {type(value).__name__}"
            ) from e

        # Constraint validation
        if param_def.constraints:
            c = param_def.constraints

            if c.minimum is not None and isinstance(value, (int, float)) and value < c.minimum:
                raise ValueError(f"Parameter '{param_def.name}' must be >= {c.minimum}")

            if c.maximum is not None and isinstance(value, (int, float)) and value > c.maximum:
                raise ValueError(f"Parameter '{param_def.name}' must be <= {c.maximum}")

            if c.minLength is not None and isinstance(value, str) and len(value) < c.minLength:
                raise ValueError(f"Parameter '{param_def.name}' must be at least {c.minLength} characters")

            if c.maxLength is not None and isinstance(value, str) and len(value) > c.maxLength:
                raise ValueError(f"Parameter '{param_def.name}' must be at most {c.maxLength} characters")

            if c.pattern is not None and isinstance(value, str):
                import re
                if not re.match(c.pattern, value):
                    raise ValueError(f"Parameter '{param_def.name}' must match pattern: {c.pattern}")

            if c.enum is not None and value not in c.enum:
                raise ValueError(f"Parameter '{param_def.name}' must be one of: {c.enum}")

        return value
