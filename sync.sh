#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔄 Syncing live configs back into the repo..."

cp ~/.zshrc "$REPO_DIR/zsh/.zshrc"
cp ~/.config/starship.toml "$REPO_DIR/starship/starship.toml"

echo "✅ Synced current configs to:"
echo "  → $REPO_DIR/zsh/.zshrc"
echo "  → $REPO_DIR/starship/starship.toml"

echo "📦 Don't forget to commit and push:"
echo "  git add zsh/.zshrc starship/starship.toml && git commit -m 'Sync latest configs'"
