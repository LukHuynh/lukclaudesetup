#!/bin/bash
set -e

echo "▶ [3/7] Python + uvx"

# Python 3 (macOS ships with it, but check)
if ! command -v python3 &>/dev/null; then
  if command -v brew &>/dev/null; then
    brew install python3
  else
    echo "  ✗ python3 not found and brew not available. Install manually."
    exit 1
  fi
fi
echo "  ✓ Python $(python3 --version)"

# uv / uvx
if command -v uvx &>/dev/null; then
  echo "  ✓ uvx $(uvx --version)"
  exit 0
fi

echo "  Installing uv (provides uvx)..."
curl -LsSf https://astral.sh/uv/install.sh | sh

# Source cargo env which uv installer adds
if [[ -f "$HOME/.cargo/env" ]]; then
  . "$HOME/.cargo/env"
fi

echo "  ✓ uvx $(uvx --version)"
