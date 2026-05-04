#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "▶ [8/8] Dotfiles"

# .zshrc — append missing lines only
ZSHRC="$HOME/.zshrc"
touch "$ZSHRC"

add_if_missing() {
  local line="$1"
  grep -qF "$line" "$ZSHRC" || echo "$line" >> "$ZSHRC"
}

add_if_missing '. "$HOME/.local/bin/env"'
add_if_missing 'export PATH="$HOME/.local/node/bin:$PATH"'
add_if_missing '. "$HOME/.cargo/env"'

echo "  ✓ .zshrc updated"
echo "  ↳ Run: source ~/.zshrc"
