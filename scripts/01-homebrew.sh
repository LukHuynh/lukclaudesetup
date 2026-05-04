#!/bin/bash
set -e

echo "▶ [1/7] Homebrew"

if command -v brew &>/dev/null; then
  echo "  ✓ Homebrew already installed"
  exit 0
fi

echo "  Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add brew to PATH for Apple Silicon
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
fi

echo "  ✓ Homebrew installed"
