#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║       Luk Claude Setup — macOS arm64     ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# Validate macOS
if [[ "$(uname)" != "Darwin" ]]; then
  echo "✗ macOS only. Exiting."
  exit 1
fi

# Validate .env exists
if [[ ! -f "$REPO_DIR/.env" ]]; then
  echo "⚠  No .env found. Copy the template first:"
  echo "   cp .env.example .env && nano .env"
  echo ""
  read -rp "Continue without API keys? (MCPs requiring keys will be skipped) [y/N] " answer
  [[ "$answer" =~ ^[Yy]$ ]] || exit 1
fi

chmod +x "$REPO_DIR"/scripts/*.sh

bash "$REPO_DIR/scripts/01-homebrew.sh"
bash "$REPO_DIR/scripts/02-node.sh"
bash "$REPO_DIR/scripts/03-python-uvx.sh"
bash "$REPO_DIR/scripts/04-claude-cli.sh"
bash "$REPO_DIR/scripts/05-claude-plugins.sh"
bash "$REPO_DIR/scripts/06-claude-config.sh"
bash "$REPO_DIR/scripts/07-mcp-setup.sh"
bash "$REPO_DIR/scripts/08-dotfiles.sh"

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║              Setup Complete ✓            ║"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "Next steps:"
echo "  1. source ~/.zshrc"
echo "  2. claude        ← authenticate with your account"
echo "  3. claude mcp list  ← verify MCP servers"
echo ""
