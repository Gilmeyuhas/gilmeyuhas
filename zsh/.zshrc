# ~/.zshrc

# --- Aliases ---
alias ll='ls -lah --color=auto'
alias b='cd ..'
sizes() {
  local paths=("$@")

  if (( $# == 0 )); then
    paths=(*)
  fi

  du -sk "${paths[@]}" 2>/dev/null \
    | sort -n \
    | awk '
        function human(bytes,   val, i, units) {
          split("B K M G T P", units, " ");
          val = bytes;
          for (i = 1; val >= 1024 && i < length(units); i++) {
            val /= 1024;
          }
          return sprintf("%.1f%s", val, units[i]);
        }

        {
          bytes = $1 * 1024;
          total += bytes;
          printf "%s\t%s\n", human(bytes), $2;
        }

        END {
          if (NR > 1) {
            printf "%s\ttotal\n", human(total);
          }
        }
      '
}
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
