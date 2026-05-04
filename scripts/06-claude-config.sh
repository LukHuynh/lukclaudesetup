#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "▶ [6/7] Claude Config"

mkdir -p "$CLAUDE_DIR/agents" "$CLAUDE_DIR/rules/ecc" "$CLAUDE_DIR/mcp-configs"

# settings.json — merge hooks block, don't overwrite entire file if exists
if [[ ! -f "$CLAUDE_DIR/settings.json" ]]; then
  cp "$REPO_DIR/claude/settings.json" "$CLAUDE_DIR/settings.json"
  echo "  ✓ settings.json copied"
else
  echo "  ↳ settings.json exists — manually review: $REPO_DIR/claude/settings.json"
fi

# AGENTS.md
cp "$REPO_DIR/claude/AGENTS.md" "$CLAUDE_DIR/AGENTS.md"
echo "  ✓ AGENTS.md"

# Custom agents (only if not already provided by a plugin)
for f in "$REPO_DIR/claude/agents/"*.md; do
  name=$(basename "$f")
  if [[ ! -f "$CLAUDE_DIR/agents/$name" ]]; then
    cp "$f" "$CLAUDE_DIR/agents/$name"
    echo "  ✓ agent: $name"
  fi
done

# Rules — always copy custom rules (these are NOT from ECC plugin)
echo "  Copying custom rules..."
cp -r "$REPO_DIR/claude/rules/." "$CLAUDE_DIR/rules/"
echo "  ✓ rules copied"

# MCP config template
cp "$REPO_DIR/claude/mcp-configs/mcp-servers.json" "$CLAUDE_DIR/mcp-configs/mcp-servers.json"
echo "  ✓ mcp-configs/mcp-servers.json (template)"

echo "  ✓ Claude config complete"
