#!/bin/bash
set -e

echo "🧹 Uninstalling terminal customizations..."

# Confirm
read -p "⚠️  This will remove your configs and restore backups. Continue? [y/N] " confirm
case "$confirm" in
[yY]*) ;;
*)
  echo "❌ Cancelled."
  exit 1
  ;;
esac

# Remove our custom files
rm -f ~/.zshrc
rm -f ~/.config/starship.toml
rm -rf ~/.zsh/zsh-autosuggestions

# Restore backups if they exist
if [ -f ~/.zshrc.backup ]; then
  mv ~/.zshrc.backup ~/.zshrc
  echo "✅ Restored ~/.zshrc from backup"
fi

if [ -f ~/.config/starship.toml.backup ]; then
  mv ~/.config/starship.toml.backup ~/.config/starship.toml
  echo "✅ Restored starship.toml from backup"
fi

# Optional: remove Starship binary
if command -v starship &>/dev/null; then
  read -p "🗑️  Also remove the Starship binary? [y/N] " remove_starship
  if [[ "$remove_starship" =~ ^[yY]$ ]]; then
    rm -f "$(command -v starship)"
    echo "✅ Removed starship binary"
  fi
fi

echo "🧽 Done. You may want to run: exec zsh -l"
