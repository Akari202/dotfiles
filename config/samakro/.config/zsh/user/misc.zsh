# Aliases
alias polaris="kitten ssh haradajm@polaris.clarkson.edu"
alias roscu="kmssh akari@128.153.194.215"
# "Shift + Tab" accept inline suggestions
bindkey '^[[Z' autosuggest-accept
# Setup zoxide
eval "$(zoxide init zsh)"
# Setup devenv
eval "$(devenv hook zsh)"
# Setup syntax highlighting
eval "$(zsh-patina activate)"



# export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
# export ZSH_AUTOSUGGEST_STRATEGY=(history)
# zstyle :compinstall filename "$HOME/.zshrc"
# autoload -Uz compinit
# compinit
# compdef ls=ls
