# ====== BLOCK START ======
bindkey -v

# NOTE: `KEYTIMEOUT` is not a env var but only meant for zsh.
#
# DO NOT set too low, ssh session cannot afford.
KEYTIMEOUT=10

# Allow deleting chars before insert mode is entered. Solve the problem where backspace
# cannot delete the history command loaded from `k` in normal mode.
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char
# ======= BLOCK END =======

# ====== BLOCK START ======
autoload -Uz add-zsh-hook
setopt PROMPT_SUBST

# Don't let `activate` prepend its own (venv) — we render it ourselves.
export VIRTUAL_ENV_DISABLE_PROMPT=1

_set_term_title() { print -Pn '\e]0;%~\a' }
add-zsh-hook precmd _set_term_title

_prompt_host()  { [[ -n "$SSH_CONNECTION" ]] && print -n " ${USER}@${HOST%%.*}" }
_prompt_venv()  { [[ -n "$VIRTUAL_ENV"   ]] && print -n " (${VIRTUAL_ENV:t})" }
_prompt_zmx()   { [[ -n "$ZMX_SESSION"   ]] && print -n "[$ZMX_SESSION] " }
_prompt_arrow() {
  if [[ $KEYMAP == vicmd ]]; then
    print -n '%F{12}[n]%f'
  else
    print -n '%F{10}[i]%f'
  fi
}

PS1='%F{3}$(_prompt_zmx)%f$(_prompt_arrow)%F{6}$(_prompt_host)%f%F{5}$(_prompt_venv)%f %F{4}%~%f > '

# Refresh the prompt based on key map (insert mode) change.
zle-keymap-select() { zle reset-prompt }

# Each time when a new line in zsh.
zle-line-init() { zle -K viins; zle reset-prompt }

zle -N zle-keymap-select
zle -N zle-line-init
# ======= BLOCK END =======

export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"

# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^y' autosuggest-accept

# fzf
# Set up fzf key bindings and fuzzy completion
# curl -LO https://github.com/junegunn/fzf/releases/download/v0.72.0/fzf-0.72.0-darwin_arm64.tar.gz
# tar -xzf fzf-0.72.0-darwin_arm64.tar.gz -C ~/.local/bin
# rm fzf-0.72.0-darwin_arm64.tar.gz

export FZF_DEFAULT_OPTS="
    --color=16,fg:-1,bg:-1,gutter:-1
    --color=hl:13,hl+:13,pointer:13,marker:10
    --color=spinner:11,info:12,header:12,border:8,prompt:7"

# <C-r>: command history
# - filtered based on current input
# <C-t>: files list (use tab to select many)
# <A-c>: find the path and cd to it
source <(fzf --zsh)

fw() {
  aerospace list-windows --all \
  | fzf --bind "enter:become(aerospace focus --window-id {1})"
}

# Color for zsh-autosuggestion virtual text.
# export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"

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

# . "${HOME}/.local/bin/env"
. "${HOME}/.cargo/env"

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
bindkey -M viins '^K' history-beginning-search-backward
bindkey -M viins '^J' history-beginning-search-forward
# ======= BLOCK END =======

# eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

zmx-select() {
  local display
  display=$(zmx list 2>/dev/null | while IFS=$'\t' read -r name pid clients created dir; do
    name=${name#*name=}
    created=${created#*created=}
    dir=${dir#*start_dir=}

    if [[ "$created" =~ ^[0-9]+$ ]]; then
      created=$(date -d "@$created" +"%Y-%m-%d %H:%M:%S" 2>/dev/null || echo "$created")
    fi

    printf "%-20s  %-19s  %s\n" "$name" "$created" "$dir"
  done)

  local output query key selected session_name
  output=$({ [[ -n "$display" ]] && echo "$display"; } | fzf \
    --print-query \
    --expect=ctrl-o \
    --height=80% \
    --reverse \
    --prompt="zmx> " \
    --header="Enter: select | Ctrl-O: create new" \
  )
  local rc=$?

  query=$(echo "$output" | sed -n '1p')
  key=$(echo "$output" | sed -n '2p')
  selected=$(echo "$output" | sed -n '3p')

  if [[ "$key" == "ctrl-o" && -n "$query" ]]; then
    session_name="$query"
  elif [[ $rc -eq 0 && -n "$selected" ]]; then
    session_name=$(echo "$selected" | awk '{print $1}')
  elif [[ -n "$query" ]]; then
    session_name="$query"
  else
    return 130
  fi

  zmx attach "$session_name"
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
alias gs="git status"
alias gb="git branch --show-current"
alias cc="claude"
alias v="nvim"
alias zz="zmx-select"


# # The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/jnwang/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jnwang/google-cloud-sdk/path.zsh.inc'; fi
# if [ -f '/Users/jnwang/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jnwang/google-cloud-sdk/completion.zsh.inc'; fi
#
# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /Users/jnwang/.local/bin/terraform terraform
#
# # kimi-code
# export PATH="/Users/jnwang/.kimi-code/bin:$PATH"
