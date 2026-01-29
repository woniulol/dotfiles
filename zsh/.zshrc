# Customize Window/Pane title.
# 1. Window/Pane title will follow pwd
precmd() {print -Pn '\e]0;%~\a'}

# 2. Instead of user@MacBookPro ~ %, it will show a nice icon
PS1=$'\uf0a9 '

# editor
export EDITOR="nvim"
export VISUAL="nvim"

# Add usr/local/bin
export PATH="$PATH:/usr/local/bin"
# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^y' autosuggest-accept

# fzf
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND="fd . --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

# Alias
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias sv="source .venv/bin/activate"

. "$HOME/.local/bin/env"
