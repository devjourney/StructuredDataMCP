"""StructuredDataMCP - Data-driven SQLite query MCP server.

This package provides a FastMCP server that exposes read-only SQLite database
queries as MCP tools through YAML configuration files.
"""

__version__ = "0.1.0"

from .models import (
    QueryDefinition,
    QueryParameter,
    ParameterConstraints,
    OutputSchema,
    Settings,
    QueryFile,
)
from .loader import QueryLoader
from .validator import SQLValidator
from .executor import QueryExecutor
from .factory import ToolFactory

__all__ = [
    "QueryDefinition",
    "QueryParameter",
    "ParameterConstraints",
    "OutputSchema",
    "Settings",
    "QueryFile",
    "QueryLoader",
    "SQLValidator",
    "QueryExecutor",
    "ToolFactory",
]
