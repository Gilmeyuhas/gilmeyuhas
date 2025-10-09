# ~/.zshrc

# --- Aliases ---
alias ll='ls -lah --color=auto'
alias b='cd ..'
alias sizes='du -sch * | gsort -h'
alias k='kubectl'
alias v='nvim'
mkcd() { mkdir -p "$1" && cd "$1"; }
path() {
  emulate -L zsh
  if (( $# == 0 )); then
    print -u2 "usage: path <file-or-dir> [...]"
    return 2
  fi
  for f in "$@"; do
    fullpath="$(realpath -- "$f" 2>/dev/null || realpath "$f")"
    print -r -- ${(q)fullpath}
  done
}
# --- Auto ll on cd ---
unfunction cd 2>/dev/null
cd() {
  builtin cd "$@" || return
  ll
}

# --- Starship prompt ---
eval "$(starship init zsh)"

# --- Autosuggestions (soft gray) ---
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#888888'
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
