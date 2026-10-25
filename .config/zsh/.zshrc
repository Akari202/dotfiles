# History settings
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=100000
HISTORY_IGNORE="(ls|cd|pwd|exit|nvim|sudo reboot|history|cd -|cd ..|fg)"

if [[ $SHLVL -gt 1 ]]; then
  PROMPT="%F{#de3d35}> %F{#30612f}%n%f%F{#A626A4}@%F{#30612f}%M%f %F{#A626A4}%B%~%b%f %F{#A626A4}%# %F{#383A42}"
else
    PROMPT="%F{#30612f}%n%f%F{#A626A4}@%F{#30612f}%M%f %F{#A626A4}%B%~%b%f %F{#A626A4}%# %F{#383A42}"
fi

# Correct misspelled commands
setopt correct
# Search for completions before expanding aliases
setopt complete_aliases
# Vim keybindings
bindkey -v
# "Shift + Tab" accept inline suggestions
bindkey '^[[Z' autosuggest-accept
# Load functions file
source "$ZDOTDIR/functions.zsh"
# Aliases
alias vim="nvim"
alias tree="tree -a -C -I '.git|venv|cmake-build-debug|.idea|.DS_Store|__pycache__|.devenv'"
alias git-tree="git log --oneline --graph --color --all --decorate"
alias git-hash="git rev-parse --short HEAD | tee pbcopy"
alias dotfiles="cd ~/dotfiles"
alias ls="uutils-ls -A --color=auto --group-directories-first --hyperlink=auto"
alias polaris="kitten ssh haradajm@polaris.clarkson.edu"
alias roscu="kmssh akari@roscu"
# Setup zoxide
eval "$(zoxide init zsh)"
# Setup devenv
eval "$(devenv hook zsh)"
# Register vim cursor function
zle -N zle-keymap-select
# Register fancy <C-z> function
zle -N fancy-ctrl-z
# Set cursor to beam
echo -ne "\e[2l\e[5 q"
# Set fancy <C-z> keybind
bindkey '^Z' fancy-ctrl-z

# export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
# export ZSH_AUTOSUGGEST_STRATEGY=(history)
# zstyle :compinstall filename "$HOME/.zshrc"
# autoload -Uz compinit
# compinit
# compdef ls=ls
