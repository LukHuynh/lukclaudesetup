#!/bin/bash
set -e

echo "▶ [2/7] Node.js"

NODE_VERSION="22"

# Prefer fnm if available
if command -v fnm &>/dev/null; then
  echo "  Installing Node $NODE_VERSION via fnm..."
  fnm install "$NODE_VERSION"
  fnm use "$NODE_VERSION"
  fnm default "$NODE_VERSION"
  echo "  ✓ Node $(node --version) via fnm"
  exit 0
fi

# Fallback: install Node to ~/.local/node (same pattern as current machine)
if [[ -x "$HOME/.local/node/bin/node" ]]; then
  echo "  ✓ Node already at ~/.local/node"
  exit 0
fi

echo "  Installing fnm..."
curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/.local/bin" --skip-shell

export PATH="$HOME/.local/bin:$PATH"
fnm install "$NODE_VERSION"
fnm use "$NODE_VERSION"
fnm default "$NODE_VERSION"

# Add to shell
echo 'eval "$(fnm env --use-on-cd)"' >> ~/.zshrc
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zprofile

echo "  ✓ Node $(node --version)"
