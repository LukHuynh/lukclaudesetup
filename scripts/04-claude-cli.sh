#!/bin/bash
set -e

echo "▶ [4/7] Claude Code CLI"

if command -v claude &>/dev/null; then
  echo "  ✓ Claude $(claude --version) already installed"
  exit 0
fi

# Ensure npm is available
if ! command -v npm &>/dev/null; then
  echo "  ✗ npm not found. Run 02-node.sh first."
  exit 1
fi

echo "  Installing @anthropic-ai/claude-code..."
npm install -g @anthropic-ai/claude-code

echo "  ✓ Claude $(claude --version)"
echo ""
echo "  Next: run 'claude' to authenticate (Claude Pro/Max account required)"
