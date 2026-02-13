"""SQL query validation and safety checks."""

import re
import sqlparse
from sqlparse.sql import Token, Identifier, IdentifierList
from sqlparse.tokens import Keyword, DML


class SQLValidator:
    """Validates SQL queries for safety and read-only enforcement."""

    # Dangerous SQL keywords that should never appear in read-only queries
    FORBIDDEN_KEYWORDS = {
        'INSERT', 'UPDATE', 'DELETE', 'DROP', 'CREATE', 'ALTER',
        'TRUNCATE', 'REPLACE', 'MERGE', 'GRANT', 'REVOKE',
        'ATTACH', 'DETACH', 'PRAGMA',  # SQLite-specific dangerous operations
    }

    # Allowed statement types
    ALLOWED_STATEMENTS = {'SELECT'}

    def __init__(self, allowed_statements: list[str] | None = None):
        """
        Initialize SQL validator.

        Args:
            allowed_statements: List of allowed SQL statement types (default: ['SELECT'])
        """
        self.allowed_statements = set(allowed_statements or ['SELECT'])

    def validate(self, sql: str) -> tuple[bool, str | None]:
        """
        Validate SQL query for safety.

        Args:
            sql: SQL query string to validate

        Returns:
            Tuple of (is_valid, error_message)
            - (True, None) if valid
            - (False, error_message) if invalid
        """
        # Parse SQL
        try:
            parsed = sqlparse.parse(sql)
        except Exception as e:
            return False, f"SQL parsing error: {str(e)}"

        if not parsed:
            return False, "Empty SQL query"

        # Check for multiple statements (prevent SQL injection via semicolon)
        if len(parsed) > 1:
            return False, "Multiple SQL statements not allowed"

        statement = parsed[0]

        # Check statement type
        stmt_type = statement.get_type()
        if stmt_type not in self.allowed_statements:
            return False, f"Statement type '{stmt_type}' not allowed. Only {self.allowed_statements} permitted."

        # Check for forbidden keywords anywhere in the query
        sql_upper = sql.upper()
        for keyword in self.FORBIDDEN_KEYWORDS:
            if re.search(r'\b' + keyword + r'\b', sql_upper):
                return False, f"Forbidden keyword '{keyword}' found in query"

        # Additional checks for SQLite-specific dangerous patterns
        dangerous_patterns = [
            (r'ATTACH\s+DATABASE', 'ATTACH DATABASE not allowed'),
            (r'PRAGMA', 'PRAGMA statements not allowed'),
            (r';\s*\S', 'Multiple statements detected'),
        ]

        for pattern, message in dangerous_patterns:
            if re.search(pattern, sql_upper):
                return False, message

        return True, None

    def extract_parameters(self, sql: str) -> set[str]:
        """
        Extract named parameter placeholders from SQL query.

        Args:
            sql: SQL query string

        Returns:
            Set of parameter names (without the : prefix)
        """
        # Match :parameter_name pattern
        pattern = r':([a-z_][a-z0-9_]*)'
        matches = re.findall(pattern, sql, re.IGNORECASE)
        return set(matches)

    def validate_parameters(self, sql: str, defined_params: list[str]) -> tuple[bool, str | None]:
        """
        Validate that SQL parameters match defined parameters.

        Args:
            sql: SQL query string
            defined_params: List of parameter names defined in YAML

        Returns:
            Tuple of (is_valid, error_message)
        """
        sql_params = self.extract_parameters(sql)
        defined_set = set(defined_params)

        # Check for parameters in SQL not defined in YAML
        undefined = sql_params - defined_set
        if undefined:
            return False, f"SQL contains undefined parameters: {', '.join(undefined)}"

        # Check for required parameters not used in SQL
        unused = defined_set - sql_params
        if unused:
            return False, f"Defined parameters not used in SQL: {', '.join(unused)}"

        return True, None
