# StructuredDataMCP

A data-driven MCP server for SQLite that exposes database queries as Claude Desktop tools—without writing Python code. Define queries in YAML, get instant MCP tools.

## Features

- **Zero-Code Extensibility**: Add new database queries by creating YAML files—no Python required
- **Type-Safe**: Automatic Pydantic validation for parameters and constraints
- **Read-Only Security**: Enforces read-only database access with SQL validation
- **Rich Relational Queries**: Support for multi-level JOINs and complex aggregations
- **Pagination Support**: Built-in limit/offset parameters for large result sets
- **FastMCP Integration**: Leverages FastMCP for seamless Claude Desktop integration

## Architecture

```
YAML Query Definitions → QueryLoader → Pydantic Models → ToolFactory → MCP Tools
                                                              ↓
                                              QueryExecutor ← SQLValidator
                                                              ↓
                                                      SQLite Database
```

**Key Principle**: The entire query catalog lives in YAML files. The Python layer handles validation, execution, and MCP tool generation automatically.

## Quick Start

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd StructuredDataMCP

# Create virtual environment
python -m venv .venv
source .venv/bin/activate
# Windows CMD: .venv\Scripts\activate
# PowerShell:
#   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
#   .\.venv\Scripts\Activate.ps1

# Install dependencies
pip install -e .
```

### Set Up Sample Database

```bash
# Create sample database with schema or use the sample.db in the repo as-is
sqlite3 examples/sample.db < examples/schema_migration.sql

# Load sample data
sqlite3 examples/sample.db < examples/sample_data.sql
```

### Check Sample DB Load and SQLite Version
```bash
python -c "import sqlite3; conn = sqlite3.connect('examples/sample.db'); print(sqlite3.sqlite_version)"
```

### Configure Claude Desktop

Add this server configuration to your Claude Desktop config file:

**macOS**: `~/Library/Application Support/Claude/claude_desktop_config.json`
**Windows**: `%APPDATA%\Claude\claude_desktop_config.json`

In Windows, this will probably resolve to C:\Users\userid\AppData\Local\Claude\claude_desktop_config.json or C:\Users\userid\AppData\Roaming\Claude\claude_desktop_config.json.

Now update the JSON file with something like:

```json
{
  "mcpServers": {
    "structured-data": {
      "command": "FULL_PATH_TO_CLONED_REPO_FOLDER/.venv/Scripts/python.exe",
      "args": [
        "FULL_PATH_TO_CLONED_REPO_FOLDER/main.py"
      ],
      "env": {}
    }
  }
}
```

**Important**: Replace `FULL_PATH_TO_CLONED_REPO_FOLDER` with the path to the root folder where you cloned this repo. In Windows, it's okay to use forward slashes in the paths, e.g. C:/Users/userid/Documents/projects/StructuredDataMCP.

### Verify Installation

1. Restart Claude Desktop
2. Look for the 🔌 icon in the bottom-right corner (or open settings and look at the tools in the Developer section)
3. Click it to see "structured-data" server connected
4. You should see 19 available tools
5. If the MCP doesn't load, check the Claude Desktop log in the same folder with the desktop configuration JSON file. If Claude doesn't fully stop, use force quit on MacOS to load it cleanly or these PowerShell commands in Windows:
- Get-Process | Where-Object { $_.ProcessName -like "*claude*" }
- Stop-Process -Name "Claude" -Force -ErrorAction SilentlyContinue

Try asking Claude:
- "Show me alice's order history"
- "What are the reviews for the Laptop Pro?"
- "Get the top 5 customers by spending"

## Database Schema

The sample database includes an e-commerce schema with rich relationships:

```
users (6 records)
  ├→ orders (15 records) → order_items (27 records) → products (14 records) → categories (4 records)
  ├→ reviews (18 records) → products
  └→ cart_items (8 records) → products
```

**Maximum traversal depth**: 4 levels (users → orders → order_items → products → categories)

## Available Tools (19 total)

### User Queries (3)
- `get_user_by_id` - Retrieve user by ID
- `search_users` - Search users with pagination
- `get_user_statistics` - Aggregate user metrics

### Product Queries (3)
- `get_products_by_category` - Filter products by category
- `search_products` - Search products with pagination
- `get_low_stock_products` - Find products below stock threshold

### Order Queries (4)
- `get_user_orders` - User's order history with summary
- `get_order_details` - Complete order with line items (4-level JOIN)
- `get_orders_by_status` - Filter by order status
- `get_order_statistics` - Aggregate order metrics

### Review Queries (3)
- `get_product_reviews` - Reviews for a product
- `get_user_reviews` - Reviews by a user
- `get_product_review_stats` - Rating distribution and statistics

### Cart Queries (2)
- `get_user_cart` - Shopping cart items with current pricing
- `get_cart_summary` - Cart totals and warnings

### Analytics Queries (4)
- `get_users_by_product` - **Reverse traversal**: who bought a product
- `get_popular_products` - Products ranked by sales
- `get_top_customers` - Customers by lifetime value
- `get_category_performance` - Categories ranked by revenue with customer reach and ratings

## Adding New Queries

The power of StructuredDataMCP is zero-code extensibility. Here's how to add a new query:

### Step 1: Create a YAML Query Definition

Create a new file or add to an existing one in `config/queries/`:

```yaml
# config/queries/my_queries.yaml
version: "1.0"
metadata:
  category: "custom"
  tags:
    - "reporting"

queries:
  - name: "get_recent_orders"
    title: "Get Recent Orders"
    description: "Retrieves orders from the last N days"

    sql: |
      SELECT
        COALESCE(o.order_id, 0) as order_id,
        COALESCE(u.username, '') as username,
        COALESCE(o.total_amount, 0) as total_amount,
        COALESCE(o.created_at, '') as created_at
      FROM orders o
      INNER JOIN users u ON o.user_id = u.user_id
      WHERE o.created_at >= datetime('now', '-' || :days || ' days')
      ORDER BY o.created_at DESC
      LIMIT :limit OFFSET :offset

    parameters:
      - name: "days"
        type: "integer"
        description: "Number of days to look back"
        required: false
        default: 7
        constraints:
          minimum: 1
          maximum: 365

      - name: "limit"
        type: "integer"
        description: "Maximum number of results"
        required: false
        default: 20
        constraints:
          minimum: 1
          maximum: 100

      - name: "offset"
        type: "integer"
        description: "Number of results to skip"
        required: false
        default: 0
        constraints:
          minimum: 0

    output_schema:
      type: "object"
      properties:
        results:
          type: "array"
          items:
            type: "object"
            properties:
              order_id:
                type: "integer"
              username:
                type: "string"
              total_amount:
                type: "number"
              created_at:
                type: "string"
        count:
          type: "integer"
```

### Step 2: Restart the MCP Server

That's it! No Python code changes needed. The server automatically:
1. Discovers the new YAML file
2. Validates the query definition
3. Generates an MCP tool with type-safe parameters
4. Makes it available to Claude Desktop

### Query Definition Patterns

Follow these conventions for consistency:

**SQL Patterns:**
- Use `COALESCE(field, default)` on all nullable fields
- Strings default to `''`, numbers to `0`
- Use named parameters: `:param_name`
- Include explicit `ORDER BY` clauses
- Use table aliases (u, o, oi, p, c, r, ci)

**Pagination:**
- Multi-record queries should include `limit` and `offset` parameters
- Use `LIMIT :limit OFFSET :offset` in SQL
- Set reasonable defaults (limit: 10-20, offset: 0)
- Set max constraints (limit: 100)

**Output Schema:**
- Always wrap results in `{results: [...], count: N}` format
- Define all fields in the output schema
- Match SQL column names to output property names

**Naming:**
- Query names: `{verb}_{entity}[_{modifier}]`
  - Examples: `get_user_by_id`, `search_products`, `get_low_stock_products`
- Parameter names: snake_case
- Use descriptive titles and descriptions

## How It Works

### 1. Query Loading (`loader.py`)

```python
loader = QueryLoader(queries_dir="config/queries")
queries = loader.load_all_queries()
```

Loads all `.yaml` files, validates against Pydantic models (`QueryFile`, `QueryDefinition`).

### 2. Tool Generation (`factory.py`)

```python
tool = ToolFactory.create_tool(query_def, executor)
```

Generates a FastMCP tool with:
- Dynamic function signature from parameters
- Type annotations
- Default values
- Full docstring

### 3. Query Execution (`executor.py`)

```python
result = await executor.execute_query(query_def, arguments)
```

Enforces:
- Read-only database access (`mode=ro`)
- SQL validation (no INSERT/UPDATE/DELETE/DROP)
- Parameter validation (types, constraints)
- Result limits (max 1000 rows)
- Query timeouts (30 seconds)

### 4. MCP Integration (`main.py`)

```python
mcp = FastMCP("StructuredDataMCP")

@mcp.tool()
async def get_user_by_id(user_id: int):
    # Auto-generated from YAML
    ...
```

FastMCP handles the MCP protocol, Claude Desktop communication, and tool invocation.

## Security Features

- **Read-Only Access**: Database opened in `mode=ro`
- **SQL Validation**: Regex-based validation blocks write operations
- **Parameter Validation**: Type checking and constraint enforcement
- **Result Limits**: Maximum 1000 rows per query
- **Query Timeouts**: 30-second execution limit
- **No Dynamic SQL**: All queries pre-defined in YAML

## Development

### Project Structure

```
StructuredDataMCP/
├── config/
│   └── queries/              # YAML query definitions
│       ├── users.yaml
│       ├── products.yaml
│       ├── orders.yaml
│       ├── reviews.yaml
│       ├── cart.yaml
│       └── analytics.yaml
├── src/structureddatamcp/
│   ├── models.py             # Pydantic models for YAML validation
│   ├── loader.py             # YAML query loader
│   ├── validator.py          # SQL validation
│   ├── executor.py           # Query execution engine
│   └── factory.py            # MCP tool factory
├── examples/
│   ├── schema_migration.sql  # Database schema
│   ├── sample_data.sql       # Sample data
│   └── sample.db             # SQLite database
├── main.py                   # MCP server entry point
└── README.md
```

### Running Tests

```bash
# Verify queries load correctly
source .venv/bin/activate
python main.py

# Should output:
# ✓ Loaded 19 query tools from .../config/queries
```

### Testing Queries Directly

```bash
# Test a query against the database
sqlite3 examples/sample.db "
SELECT
  COALESCE(u.username, '') as username,
  COALESCE(COUNT(o.order_id), 0) as order_count
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.username
ORDER BY order_count DESC;
"
```

## Example Usage with Claude Desktop

Once configured, you can ask Claude natural language questions that map to your tools:

**User**: "Show me all the orders for user alice"

**Claude**: *Uses `get_user_orders` tool with search to find alice's user_id, then retrieves orders*

**User**: "What are the top 3 best-selling products?"

**Claude**: *Uses `get_popular_products` tool with limit=3*

**User**: "Which users have bought wireless headphones?"

**Claude**: *Uses `get_users_by_product` tool (reverse traversal)*

**User**: "Show me the review statistics for the laptop"

**Claude**: *Uses `get_product_review_stats` tool with product search*

## Extending to Your Own Database

1. **Replace the database**:
   ```bash
   cp your_database.db examples/sample.db
   ```

2. **Explore the schema**:
   ```bash
   sqlite3 examples/sample.db ".schema"
   ```

3. **Create query definitions**:
   - Add YAML files in `config/queries/`
   - Follow the patterns in existing queries
   - Use COALESCE for NULL safety
   - Add pagination for multi-record results

4. **Test queries**:
   ```bash
   # Test SQL directly first
   sqlite3 examples/sample.db "YOUR SQL HERE"
   ```

5. **Restart Claude Desktop**

## Best Practices

1. **Always use COALESCE**: Prevents NULL values from breaking JSON serialization
2. **Test queries directly**: Use sqlite3 CLI before adding to YAML
3. **Add pagination**: Multi-record queries should support limit/offset
4. **Document thoroughly**: Clear descriptions help Claude choose the right tool
5. **Use constraints**: Min/max values prevent abuse and errors
6. **Follow naming conventions**: Consistent naming improves discoverability
7. **Start with SELECT**: Queries are read-only by design

## Troubleshooting

### Server Not Showing in Claude Desktop

1. Check config file syntax (valid JSON)
2. Verify absolute paths to Python and main.py
3. Check Claude Desktop logs:
   - macOS: `~/Library/Logs/Claude/`
   - Windows: `%APPDATA%\Claude\logs\`
4. Restart Claude Desktop completely (quit and relaunch)

### Query Not Working

1. Test SQL directly with sqlite3
2. Check YAML syntax (indentation, colons)
3. Verify COALESCE on all nullable fields
4. Check parameter names match SQL (`:param_name`)
5. Look at server stderr output for validation errors

### Database Not Found

Ensure paths in `main.py` are absolute or relative to the script location:

```python
DB_PATH = Path(__file__).parent / "examples" / "sample.db"
QUERIES_DIR = Path(__file__).parent / "config" / "queries"
```

## License

MIT

## Contributing

Contributions welcome! Please:
1. Follow existing YAML patterns
2. Add comprehensive descriptions
3. Include example queries in PR description
4. Test with Claude Desktop before submitting

## Acknowledgments

Built with [FastMCP](https://gofastmcp.com) - The fastest way to build MCP servers.
