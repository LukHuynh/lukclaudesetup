#!/bin/bash
set -e

echo "▶ [5/7] Claude Plugins"

if ! command -v claude &>/dev/null; then
  echo "  ✗ claude not found. Run 04-claude-cli.sh first."
  exit 1
fi

PLUGINS=(
  "compound-engineering-plugin:compound-engineering-plugin:EveryInc/compound-engineering-plugin"
  "caveman:caveman:JuliusBrussee/caveman"
  "karpathy-skills:karpathy-skills:forrestchang/andrej-karpathy-skills"
  "last30days-skill:last30days-skill:mvanhorn/last30days-skill"
)

for entry in "${PLUGINS[@]}"; do
  IFS=':' read -r name marketplace repo <<< "$entry"
  echo "  Installing plugin: $name from $repo..."
  claude plugin install "github:$repo" --marketplace "$marketplace" --yes 2>/dev/null || \
    echo "    ↳ Already installed or skipped: $name"
done

echo "  ✓ Plugins installed"
