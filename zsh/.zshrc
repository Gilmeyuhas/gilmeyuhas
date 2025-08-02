# ~/.zshrc

# --- Aliases ---
alias ll='ls -lah --color=auto'
alias b='cd ..'
alias sizes='du -sch * | gsort -h'
alias k='kubectl'
alias v='nvim'
mkcd() { mkdir -p "$1" && cd "$1"; }

# --- Auto ll on cd ---
unfunction cd 2>/dev/null
cd() {
  builtin cd "$@" || return
  ll
}

# Starship prompt
eval "$(starship init zsh)"

# Autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=brightwhite'
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- Starship prompt ---
eval "$(starship init zsh)"

