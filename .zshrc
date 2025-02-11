# ZSH settings
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# bindkey v
# autoload -Uz compinit
# compinit
export HISTORY_IGNORE="(ls|cd|pwd|exit|nvim|sudo reboot|history|cd -|cd ..)"
export PATH="$PATH:/home/haradajm/main/install/bin:/home/haradajm/.cargo/bin"

PROMPT="%n%f@%M%f %B%~%b%f %# "
# PROMPT="%F{#50fa7b}%n%f%F{#bd93f9}@%F{#50fa7b}%M%f %F{#bd93f9}%B%~%b%f %F{#bd93f9}%# %F{#f8f8f2} %{$reset_color%}%% "

# Aliases
alias ls="ls -A --color=auto --group-directories-first"

# ENV veriables
export GPG_TTY=$(tty)
export EDITOR=vim
export TERM=xterm-256color

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

# Trash
trash () {
    mv $1 /home/haradajm/main/.trash/

eval "$(zoxide init zsh)"

neofetch | lolcat
