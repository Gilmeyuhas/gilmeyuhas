#!/bin/bash

set -e

echo "🌈 Installing Zsh environment..."

# Ensure Homebrew
if ! command -v brew &>/dev/null; then
  echo "❌ Homebrew not found. Please install it first: https://brew.sh"
  exit 1
fi

# Install dependencies
brew install starship
brew install --cask font-meslo-lg-nerd-font
brew install zsh

# Optional: syntax highlighting
# brew install zsh-syntax-highlighting

# Create config folders
mkdir -p ~/.config
mkdir -p ~/.zsh

# Copy configs
cp starship/starship.toml ~/.config/starship.toml
cp zsh/.zshrc ~/.zshrc

# Set up autosuggestions
cp -r zsh/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

echo "✅ Installed starship.toml and .zshrc"

# Optional: add syntax highlighting
# echo "source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

# Reload shell
exec zsh -l
