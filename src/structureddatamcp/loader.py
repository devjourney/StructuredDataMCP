"""YAML query definition loader with validation."""

import yaml
from pathlib import Path
from typing import Iterator
from pydantic import ValidationError
from .models import QueryFile, QueryDefinition, Settings


class QueryLoader:
    """Loads and validates query definitions from YAML files."""

    def __init__(self, config_dir: Path):
        """
        Initialize query loader.

        Args:
            config_dir: Path to directory containing query YAML files
        """
        self.config_dir = Path(config_dir)
        if not self.config_dir.exists():
            raise FileNotFoundError(f"Config directory not found: {config_dir}")

    def load_settings(self, settings_path: Path | None = None) -> Settings:
        """
        Load server settings from YAML file.

        Args:
            settings_path: Path to settings.yaml (defaults to config_dir/settings.yaml)

        Returns:
            Validated Settings object
        """
        if settings_path is None:
            settings_path = self.config_dir / "settings.yaml"

        with open(settings_path, 'r') as f:
            data = yaml.safe_load(f)

        return Settings(**data)

    def load_query_file(self, file_path: Path) -> QueryFile:
        """
        Load and validate a single query definition file.

        Args:
            file_path: Path to YAML file

        Returns:
            Validated QueryFile object

        Raises:
            ValidationError: If YAML structure is invalid
        """
        with open(file_path, 'r') as f:
            data = yaml.safe_load(f)

        try:
            return QueryFile(**data)
        except ValidationError as e:
            raise ValidationError(f"Invalid query file {file_path}: {e}") from e

    def load_all_queries(self, queries_dir: Path | None = None) -> Iterator[QueryDefinition]:
        """
        Load all query definitions from YAML files in queries directory.

        Args:
            queries_dir: Path to queries directory (defaults to config_dir/queries)

        Yields:
            QueryDefinition objects from all YAML files
        """
        if queries_dir is None:
            queries_dir = self.config_dir / "queries"

        if not queries_dir.exists():
            raise FileNotFoundError(f"Queries directory not found: {queries_dir}")

        # Load all .yaml and .yml files
        for yaml_file in sorted(queries_dir.glob("*.y*ml")):
            query_file = self.load_query_file(yaml_file)

            # Yield each query definition
            for query in query_file.queries:
                # Optionally merge file-level metadata with query-level metadata
                if query_file.metadata and query_file.metadata.tags:
                    if query.mcp_metadata is None:
                        from .models import MCPMetadata
                        query.mcp_metadata = MCPMetadata()
                    if query.mcp_metadata.tags is None:
                        query.mcp_metadata.tags = []
                    query.mcp_metadata.tags.extend(query_file.metadata.tags)

                yield query

    def get_query_by_name(self, name: str, queries_dir: Path | None = None) -> QueryDefinition | None:
        """
        Find a specific query by name.

        Args:
            name: Query/tool name to find
            queries_dir: Path to queries directory

        Returns:
            QueryDefinition if found, None otherwise
        """
        for query in self.load_all_queries(queries_dir):
            if query.name == name:
                return query
        return None
