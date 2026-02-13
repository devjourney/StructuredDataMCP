"""Pydantic models for validating YAML query definitions."""

from typing import Any, Literal, Optional
from pydantic import BaseModel, Field, field_validator
import re


class ParameterConstraints(BaseModel):
    """Validation constraints for query parameters."""
    minimum: Optional[int] = None
    maximum: Optional[int] = None
    minLength: Optional[int] = None
    maxLength: Optional[int] = None
    pattern: Optional[str] = None
    enum: Optional[list[Any]] = None


class QueryParameter(BaseModel):
    """Definition of a query parameter."""
    name: str = Field(..., description="Parameter name as used in SQL (:param_name)")
    type: Literal["string", "integer", "number", "boolean"] = Field(
        ..., description="Parameter data type"
    )
    description: str = Field(..., description="Human-readable parameter description")
    required: bool = Field(default=True, description="Whether parameter is required")
    default: Optional[Any] = None
    constraints: Optional[ParameterConstraints] = None

    @field_validator('name')
    @classmethod
    def validate_parameter_name(cls, v: str) -> str:
        """Validate parameter name follows SQL naming conventions."""
        if not re.match(r'^[a-z_][a-z0-9_]*$', v):
            raise ValueError(
                f"Parameter name '{v}' must start with lowercase letter or underscore "
                "and contain only lowercase letters, numbers, and underscores"
            )
        return v


class OutputSchemaProperty(BaseModel):
    """JSON Schema property definition for output."""
    type: str
    description: Optional[str] = None
    format: Optional[str] = None
    items: Optional[dict[str, Any]] = None


class OutputSchema(BaseModel):
    """JSON Schema definition for query output."""
    type: Literal["object"] = Field(default="object")
    description: Optional[str] = None
    properties: dict[str, Any] = Field(
        ..., description="Object properties matching query result structure"
    )
    required: Optional[list[str]] = None


class MCPIcon(BaseModel):
    """MCP tool icon definition."""
    url: str
    mimeType: Optional[str] = None


class MCPMetadata(BaseModel):
    """Additional MCP tool metadata."""
    tags: Optional[list[str]] = None
    icons: Optional[list[MCPIcon]] = None


class QueryDefinition(BaseModel):
    """Complete definition of a database query tool."""
    name: str = Field(..., description="Unique tool name (e.g., get_user_by_id)")
    title: Optional[str] = Field(None, description="Human-readable tool title")
    description: str = Field(..., description="Tool description for LLM context")
    sql: str = Field(..., description="SQL query with named parameters (:param_name)")
    parameters: list[QueryParameter] = Field(
        default_factory=list, description="Query parameter definitions"
    )
    output_schema: Optional[OutputSchema] = None
    mcp_metadata: Optional[MCPMetadata] = None

    @field_validator('name')
    @classmethod
    def validate_tool_name(cls, v: str) -> str:
        """Validate tool name follows MCP conventions."""
        if not re.match(r'^[a-z_][a-z0-9_]*$', v):
            raise ValueError(
                f"Tool name '{v}' must start with lowercase letter or underscore "
                "and contain only lowercase letters, numbers, and underscores"
            )
        return v

    @field_validator('sql')
    @classmethod
    def validate_sql_basic(cls, v: str) -> str:
        """Basic SQL validation - more thorough validation happens in validator.py."""
        sql_upper = v.strip().upper()
        if not sql_upper.startswith('SELECT'):
            raise ValueError("Only SELECT queries are allowed")
        return v


class QueryFileMetadata(BaseModel):
    """Metadata for a query definition file."""
    category: Optional[str] = None
    tags: Optional[list[str]] = None


class QueryFile(BaseModel):
    """Complete structure of a query definition YAML file."""
    version: str = Field(default="1.0")
    metadata: Optional[QueryFileMetadata] = None
    queries: list[QueryDefinition] = Field(..., min_length=1)


class ServerSettings(BaseModel):
    """Server configuration settings."""
    name: str = Field(default="SQLite Query Server")
    version: str = Field(default="1.0.0")
    description: str = Field(default="Read-only SQLite database query server")


class DatabaseSettings(BaseModel):
    """Database connection settings."""
    path: str = Field(..., description="Path to SQLite database file")
    pool_size: int = Field(default=5, ge=1, le=20)
    timeout: int = Field(default=30, ge=1, le=300)


class SecuritySettings(BaseModel):
    """Security configuration."""
    read_only: bool = Field(default=True)
    allowed_statements: list[str] = Field(default=["SELECT"])
    max_results: int = Field(default=1000, ge=1, le=10000)
    query_timeout: int = Field(default=30, ge=1, le=300)


class Settings(BaseModel):
    """Complete server settings."""
    server: ServerSettings = Field(default_factory=ServerSettings)
    database: DatabaseSettings
    security: SecuritySettings = Field(default_factory=SecuritySettings)
