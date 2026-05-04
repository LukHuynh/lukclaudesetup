#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "▶ [7/7] MCP Servers"

# Load .env if present
if [[ -f "$REPO_DIR/.env" ]]; then
  set -a
  source "$REPO_DIR/.env"
  set +a
  echo "  Loaded .env"
else
  echo "  ⚠ No .env found — MCP servers requiring API keys will be skipped"
  echo "    Run: cp $REPO_DIR/.env.example $REPO_DIR/.env && nano $REPO_DIR/.env"
fi

if ! command -v claude &>/dev/null; then
  echo "  ✗ claude not found. Run 04-claude-cli.sh first."
  exit 1
fi

add_mcp() {
  local name="$1"
  shift
  echo "  Adding MCP: $name"
  claude mcp add "$name" "$@" 2>/dev/null || echo "    ↳ Already exists or failed: $name"
}

# ── No-key servers (always add) ───────────────────────────────────────────────
add_mcp memory          -s user -- npx -y @modelcontextprotocol/server-memory
add_mcp omega-memory    -s user -- uvx omega-memory serve
add_mcp sequential-thinking -s user -- npx -y @modelcontextprotocol/server-sequential-thinking
add_mcp context7        -s user -- npx -y @upstash/context7-mcp@latest
add_mcp magic           -s user -- npx -y @magicuidesign/mcp@latest
add_mcp playwright      -s user -- npx -y @playwright/mcp --browser chrome
add_mcp token-optimizer -s user -- npx -y token-optimizer-mcp

# ── HTTP servers (no auth needed) ─────────────────────────────────────────────
add_mcp vercel                  -s user --transport http https://mcp.vercel.com
add_mcp cloudflare-docs         -s user --transport http https://docs.mcp.cloudflare.com/mcp
add_mcp cloudflare-workers-builds   -s user --transport http https://builds.mcp.cloudflare.com/mcp
add_mcp cloudflare-workers-bindings -s user --transport http https://bindings.mcp.cloudflare.com/mcp
add_mcp cloudflare-observability    -s user --transport http https://observability.mcp.cloudflare.com/mcp
add_mcp clickhouse              -s user --transport http https://mcp.clickhouse.cloud/mcp
add_mcp laraplugins             -s user --transport http https://laraplugins.io/mcp/plugins
add_mcp railway                 -s user -- npx -y @railway/mcp-server

# ── Key-gated servers ─────────────────────────────────────────────────────────
[[ -n "$GITHUB_PERSONAL_ACCESS_TOKEN" ]] && \
  add_mcp github -s user -e GITHUB_PERSONAL_ACCESS_TOKEN="$GITHUB_PERSONAL_ACCESS_TOKEN" -- \
    npx -y @modelcontextprotocol/server-github

[[ -n "$JIRA_URL" && -n "$JIRA_API_TOKEN" ]] && \
  add_mcp jira -s user \
    -e JIRA_URL="$JIRA_URL" \
    -e JIRA_EMAIL="$JIRA_EMAIL" \
    -e JIRA_API_TOKEN="$JIRA_API_TOKEN" \
    -- uvx mcp-atlassian==0.21.0

[[ -n "$CONFLUENCE_BASE_URL" && -n "$CONFLUENCE_API_TOKEN" ]] && \
  add_mcp confluence -s user \
    -e CONFLUENCE_BASE_URL="$CONFLUENCE_BASE_URL" \
    -e CONFLUENCE_EMAIL="$CONFLUENCE_EMAIL" \
    -e CONFLUENCE_API_TOKEN="$CONFLUENCE_API_TOKEN" \
    -- npx -y confluence-mcp-server

[[ -n "$FIRECRAWL_API_KEY" ]] && \
  add_mcp firecrawl -s user -e FIRECRAWL_API_KEY="$FIRECRAWL_API_KEY" -- npx -y firecrawl-mcp

[[ -n "$EXA_API_KEY" ]] && \
  add_mcp exa-web-search -s user -e EXA_API_KEY="$EXA_API_KEY" -- npx -y exa-mcp-server

[[ -n "$FAL_KEY" ]] && \
  add_mcp fal-ai -s user -e FAL_KEY="$FAL_KEY" -- npx -y fal-ai-mcp-server

[[ -n "$BROWSERBASE_API_KEY" ]] && \
  add_mcp browserbase -s user -e BROWSERBASE_API_KEY="$BROWSERBASE_API_KEY" -- \
    npx -y @browserbasehq/mcp-server-browserbase

[[ -n "$SUPABASE_PROJECT_REF" ]] && \
  add_mcp supabase -s user -- \
    npx -y @supabase/mcp-server-supabase@latest "--project-ref=$SUPABASE_PROJECT_REF"

[[ -n "$OPENAI_API_KEY" ]] && \
  add_mcp evalview -s user -e OPENAI_API_KEY="$OPENAI_API_KEY" -- python3 -m evalview mcp serve

echo "  ✓ MCP setup complete"
echo "  Run 'claude mcp list' to verify"
