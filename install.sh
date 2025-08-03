#!/bin/bash

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🌈 Starting terminal environment setup..."

OS=$(uname -s)
IS_SERVER=false

# Ask if Linux server
if [ "$OS" = "Linux" ]; then
  read -p "🖥️  Is this a server-only environment (no GUI)? [y/N] " answer
  case $answer in
  [Yy]*) IS_SERVER=true ;;
  esac
fi

# ─────────── Install tools ─────────────

if [ "$OS" = "Darwin" ]; then
  echo "🍎 macOS detected"

  # Homebrew check
  if ! command -v brew &>/dev/null; then
    echo "❌ Homebrew not found. Please install it first: https://brew.sh"
    exit 1
  fi

  brew install zsh starship
  brew install --cask font-meslo-lg-nerd-font

elif [ "$OS" = "Linux" ]; then
  echo "🐧 Linux detected"

  sudo apt update
  sudo apt install -y zsh git curl

  # Install Starship if not found
  if ! command -v starship &>/dev/null; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
    echo 'export PATH="$HOME/.cargo/bin:$PATH"' >>~/.profile
    export PATH="$HOME/.cargo/bin:$PATH"
  fi
else
  echo "⚠️ Unsupported OS: $OS"
  exit 1
fi

# ─────────── Copy config files ─────────────
# Backup existing config files (if not already backed up)
if [ -f ~/.zshrc ] && [ ! -f ~/.zshrc.backup ]; then
  cp ~/.zshrc ~/.zshrc.backup
  echo "💾 Backed up existing ~/.zshrc to ~/.zshrc.backup"
fi

if [ -f ~/.config/starship.toml ] && [ ! -f ~/.config/starship.toml.backup ]; then
  cp ~/.config/starship.toml ~/.config/starship.toml.backup
  echo "💾 Backed up existing starship.toml"
fi
mkdir -p ~/.zsh
mkdir -p ~/.config

cp "$REPO_DIR/zsh/.zshrc" ~/.zshrc
cp "$REPO_DIR/starship/starship.toml" ~/.config/starship.toml

# Clone autosuggestions if not already there
if [ ! -d ~/.zsh/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi

# Fix Zsh as default shell (optional)
if command -v chsh &>/dev/null; then
  echo "🛠️  Setting Zsh as your default shell..."
  chsh -s "$(which zsh)" || true
fi

echo "✅ Config files installed"

# ─────────── Reminder / Finish ─────────────

if [ "$IS_SERVER" = false ]; then
  echo "💡 Tip: Set MesloLGS Nerd Font in your terminal preferences"
fi

echo "🚀 Done! Launching your rainbow Zsh session..."

exec zsh -l
