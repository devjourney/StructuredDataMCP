"""Factory for creating FastMCP tools from query definitions."""

from typing import Any, Callable
from fastmcp.tools import Tool
from .models import QueryDefinition, QueryParameter
from .executor import QueryExecutor


class ToolFactory:
    """Creates FastMCP Tool instances from query definitions."""

    def __init__(self, executor: QueryExecutor):
        """
        Initialize tool factory.

        Args:
            executor: Query executor instance
        """
        self.executor = executor

    def create_tool(self, query_def: QueryDefinition) -> Tool:
        """
        Create a FastMCP Tool from a query definition.

        Args:
            query_def: Query definition from YAML

        Returns:
            FastMCP Tool instance
        """
        # Build JSON Schema for parameters
        parameters_schema = self._build_parameter_schema(query_def.parameters)

        # Create async function for tool execution
        async def execute_query(**kwargs: Any) -> dict[str, Any]:
            """Execute the database query with provided parameters."""
            result = await self.executor.execute_query(query_def, kwargs)
            return result

        # Set function metadata for FastMCP introspection
        execute_query.__name__ = query_def.name
        execute_query.__doc__ = query_def.description

        # Create Tool using from_function
        tool = Tool.from_function(
            fn=execute_query,
            name=query_def.name,
            title=query_def.title,
            description=query_def.description,
            output_schema=query_def.output_schema.model_dump() if query_def.output_schema else None,
        )

        # Override parameters with our custom schema
        tool.parameters = parameters_schema

        # Add MCP metadata if provided
        if query_def.mcp_metadata:
            if query_def.mcp_metadata.tags:
                tool.tags = set(query_def.mcp_metadata.tags)

            if query_def.mcp_metadata.icons:
                from mcp.types import Icon
                tool.icons = [
                    Icon(url=icon.url, mimeType=icon.mimeType)
                    for icon in query_def.mcp_metadata.icons
                ]

        return tool

    def _build_parameter_schema(self, params: list[QueryParameter]) -> dict[str, Any]:
        """
        Build JSON Schema for tool parameters.

        Args:
            params: List of parameter definitions

        Returns:
            JSON Schema dict for parameters
        """
        properties = {}
        required = []

        for param in params:
            # Map parameter type to JSON Schema type
            json_type = self._map_type(param.type)

            prop_schema: dict[str, Any] = {
                "type": json_type,
                "description": param.description,
            }

            # Add default if provided
            if param.default is not None:
                prop_schema["default"] = param.default

            # Add constraints
            if param.constraints:
                c = param.constraints
                if c.minimum is not None:
                    prop_schema["minimum"] = c.minimum
                if c.maximum is not None:
                    prop_schema["maximum"] = c.maximum
                if c.minLength is not None:
                    prop_schema["minLength"] = c.minLength
                if c.maxLength is not None:
                    prop_schema["maxLength"] = c.maxLength
                if c.pattern is not None:
                    prop_schema["pattern"] = c.pattern
                if c.enum is not None:
                    prop_schema["enum"] = c.enum

            properties[param.name] = prop_schema

            # Track required parameters
            if param.required and param.default is None:
                required.append(param.name)

        schema = {
            "type": "object",
            "properties": properties,
        }

        if required:
            schema["required"] = required

        return schema

    @staticmethod
    def _map_type(param_type: str) -> str:
        """Map parameter type to JSON Schema type."""
        type_mapping = {
            "string": "string",
            "integer": "integer",
            "number": "number",
            "boolean": "boolean",
        }
        return type_mapping.get(param_type, "string")
