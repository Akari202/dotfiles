# ZSH settings
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt correct
bindkey -v
zstyle :compinstall filename "/Users/ellie/.zshrc"
autoload -Uz compinit
compinit
export HISTORY_IGNORE="(ls|cd|pwd|exit|nvim|sudo reboot|history|cd -|cd ..)"

# macOS specific tasks
if [[ "$OSTYPE" =~ ^darwin ]]; then
    # Prompt
    # PROMPT="%F{#50fa7b}%n%f%F{#bd93f9}@%F{#50fa7b}akari%f %F{#bd93f9}%B%~%b%f %F{#bd93f9}%# %F{#f8f8f2}"
    PROMPT="%F{#30612f}%n%f%F{#A626A4}@%F{#30612f}akari%f %F{#A626A4}%B%~%b%f %F{#A626A4}%# %F{#383A42}"

    # Load nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

    # TODO: fix path variable
    export PATH=$PATH:/Users/ellie/.spicetify:/Users/ellie/.local/bin:/usr/local/opt/ccache/libexec
    export JAVA_HOME=$(/usr/libexec/java_home -v 21)
    export PATH=$JAVA_HOME/bin:$PATH
    export HOMEBREW_NO_AUTO_UPDATE=1

    # Aliases
    alias dotfiles="cd /Users/ellie/Downloads/Utility/dotfiles/"
    alias ls="ls -A --color=auto"
    alias doas="sudo"
    alias sl="sl | lolcat && fortune | uwuify | cowsay && ls -A --color=auto"
    alias polaris="ssh -t -i /Users/ellie/.ssh/id_ed25519_polaris haradajm@polaris.clarkson.edu"
fi

# Linux specific tasks
if [[ "$OSTYPE" =~ ^linux ]]; then
    # Prompt
    # PROMPT="%F{#50fa7b}%n%f%F{#bd93f9}@%F{#50fa7b}%M%f %F{#bd93f9}%B%~%b%f %F{#bd93f9}%# %F{#f8f8f2}"
    PROMPT="%F{#30612f}%n%f%F{#A626A4}@%F{#30612f}%M%f %F{#A626A4}%B%~%b%f %F{#A626A4}%# %F{#383A42}"

    # Aliases
    alias dotfiles="cd /home/akari/Downloads/util/dotfiles/"
    alias trash="trash-put"
    alias watch_something="python3 /home/akari/Downloads/sort/movies_to_sort/what_to_watch/main.py"
    alias ls="ls -A --color=auto --group-directories-first"
    alias sl="sl | lolcat && fortune | uwuify | cowsay && ls -A --color=auto --group-directories-first"

    # ENV veriables
    export GPG_TTY=$(tty)
    export EDITOR=nvim
    export VISUAL=neovide

    # pnpm
    export PNPM_HOME="/home/akari/.local/share/pnpm"

    alias polaris="ssh haradajm@polaris.clarkson.edu"
    export PATH="$PNPM_HOME:$PATH:/home/akari/.local/share/gem/ruby/3.0.0/bin"
    export LFS="/media/orisson"
fi

# General aliases
alias neo="neofetch | lolcat"
alias one="onefetch | lolcat"
alias fort="fortune | uwuify | cowsay"
alias vim="nvim"
alias git-tree="git log --oneline --graph --color --all --decorate"

# Sha checker
sha256() {
    printf "%s %s\n" "$1" "$2" | sha256sum --check
}

### ARCHIVE EXTRACTION
# usage: ex <file>
ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.jar)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

### Make and enter a director
# usage: mz <dir>
mz () {
    mkdir $1
    cd ./$1
}

# Greeting for new terminal windows
echo
# neofetch | lolcat
fortune


[ -f "/Users/ellie/.ghcup/env" ] && source "/Users/ellie/.ghcup/env" # ghcup-env

eval "$(zoxide init zsh)"

