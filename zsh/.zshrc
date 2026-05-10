# ====== BLOCK START ======
bindkey -v

# NOTE: `KEYTIMEOUT` is not a env var but only meant for zsh.
KEYTIMEOUT=1

# Allow deleting chars before insert mode is entered. Solve the problem where backspace
# cannot delete the history command loaded from `k` in normal mode.
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char
# ======= BLOCK END =======

# ====== BLOCK START ======
# Single-line prompt: host, venv, then mode arrow.
# Slots 10/12 are reserved for vi mode (matches nvim statusline).
#   host=brred(9)  cwd=cyan(6)  venv=magenta(5)
#   arrow: brblue(12) in normal, brgreen(10) in insert
autoload -Uz add-zsh-hook
setopt PROMPT_SUBST

# Don't let `activate` prepend its own (venv) — we render it ourselves.
export VIRTUAL_ENV_DISABLE_PROMPT=1

_set_term_title() { print -Pn '\e]0;%~\a' }
add-zsh-hook precmd _set_term_title

_prompt_host()  { [[ -n "$SSH_CONNECTION" ]] && print -n " ${HOST%%.*}" }
_prompt_venv()  { [[ -n "$VIRTUAL_ENV"   ]] && print -n " (${VIRTUAL_ENV:t})" }
_prompt_arrow() {
  if [[ $KEYMAP == vicmd ]]; then
    print -n '%F{12}[n]%f'
  else
    print -n '%F{10}[i]%f'
  fi
}

PS1='$(_prompt_arrow)%F{9}$(_prompt_host)%f%F{5}$(_prompt_venv)%f > '

zle-keymap-select() { zle reset-prompt }
zle-line-init()     { zle -K viins; zle reset-prompt }
zle -N zle-keymap-select
zle -N zle-line-init
# ======= BLOCK END =======

# editor
export PATH="$PATH:/opt/nvim-macos-arm64/bin"
# export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export EDITOR="nvim"
export VISUAL="nvim"

# Add usr/local/bin
export PATH="$PATH:/usr/local/bin"
# Add Visual Studio Code (code)
# export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^y' autosuggest-accept

# fzf
# Set up fzf key bindings and fuzzy completion
#
# <C-r>: command history
# - filtered based on current input
# <C-t>: files list (use tab to select many)
# <A-c>: find the path and cd to it
source <(fzf --zsh)
# export FZF_DEFAULT_COMMAND="fd . --hidden --exclude .git"
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

fw() {
  aerospace list-windows --all \
  | fzf --bind "enter:become(aerospace focus --window-id {1})"
}

# Alias
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias sv="source .venv/bin/activate"
alias dv="deactivate"
alias gfa="git fetch --all"
alias cc="claude"
alias v="nvim"

# Color for zsh-autosuggestion virtual text.
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"

# Open buffer line in editor with v
autoload -Uz edit-command-line
zle -N edit-command-line
vicmd_edit_command_line() {
  zle edit-command-line
  CURSOR=${#BUFFER}
  zle vi-insert
}
zle -N vicmd_edit_command_line
bindkey -M vicmd 'v' vicmd_edit_command_line

# Insert git commit command and move cursor to the middle with Ctrl+x p+c
gc_commit_widget() {
  BUFFER='git commit -m ""'
  CURSOR=$(( ${#BUFFER} - 1 ))   # place cursor between the quotes
  zle vi-insert                  # switch to insert mode
}
zle -N gc_commit_widget
bindkey -M vicmd 'gc' gc_commit_widget

. "${HOME}/.local/bin/env"

# ====== BLOCK START ======
# History configuration
HISTSIZE=10000
SAVEHIST="${HISTSIZE}"
HISTDUP="erase"
HISTFILE="${HOME}/.zsh_history"
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Match prefix for both n and i mode.
bindkey -M viins "^[[A" history-beginning-search-backward
bindkey -M viins "^[[B" history-beginning-search-forward
bindkey -M vicmd "^[[A" history-beginning-search-backward
bindkey -M vicmd "^[[B" history-beginning-search-forward
bindkey -M vicmd 'k' history-beginning-search-backward
bindkey -M vicmd 'j' history-beginning-search-forward
# ======= BLOCK END =======


# eval "$(starship init zsh)"
