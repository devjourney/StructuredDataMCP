"""Factory for creating FastMCP tools from query definitions."""

from typing import Any, Callable, Optional
from fastmcp.tools import Tool
from .models import QueryDefinition, QueryParameter
from .executor import QueryExecutor
import inspect


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

        # Create function with explicit parameters dynamically
        executor = self.executor

        # Build parameter list with defaults
        param_names = []
        param_defaults = []
        for param in query_def.parameters:
            param_names.append(param.name)
            if param.default is not None:
                param_defaults.append(param.default)
            elif not param.required:
                param_defaults.append(None)

        # Create function signature string
        param_strs = []
        default_start_idx = len(param_names) - len(param_defaults)
        for i, name in enumerate(param_names):
            if i >= default_start_idx:
                default_val = param_defaults[i - default_start_idx]
                param_strs.append(f"{name}=None")
            else:
                param_strs.append(name)

        params_signature = ", ".join(param_strs)

        # Build the function code
        func_code = f"""
async def {query_def.name}({params_signature}):
    '''Execute the database query with provided parameters.'''
    arguments = {{{", ".join(f'"{name}": {name}' for name in param_names)}}}
    result = await executor.execute_query(query_def, arguments)
    return result
"""

        # Execute the code to create the function
        local_vars = {"executor": executor, "query_def": query_def}
        exec(func_code, local_vars)
        execute_query = local_vars[query_def.name]

        # Set function documentation
        execute_query.__doc__ = query_def.description

        # Create Tool using from_function
        tool = Tool.from_function(
            fn=execute_query,
            name=query_def.name,
            title=query_def.title,
            description=query_def.description,
            output_schema=query_def.output_schema.model_dump(exclude_none=True) if query_def.output_schema else None,
        )

        # Override parameters with our custom schema to ensure correct types and constraints
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
