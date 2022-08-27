# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/ellie/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export HISTORY_IGNORE="(ls|cd|pwd|exit|vim|sudo reboot|history|cd -|cd ..)"

PROMPT='%F{#50fa7b}%n%f%F{#bd93f9}@%F{#50fa7b}akari%f %F{#bd93f9}%B%~%b%f %F{#bd93f9}%# %F{#f8f8f2}'

alias neo="neofetch | lolcat"
alias one="onefetch | lolcat"
alias fort="fortune | uwuify | cowsay | lolcat"
alias sl="sl | lolcat && fortune | uwuify | cowsay | lolcat"
alias ls="ls -a --color=auto"
alias vim="nvim"
alias vi="nvim"
# TODO make this not an absolute path so it works on both my computers
alias dotfiles="cd /Users/ellie/Downloads/Utility/dotfiles/ && nvim"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH=$PATH:/Users/ellie/.spicetify

sha256() {
    printf '%s %s\n' "$1" "$2" | sha256sum --check
}

### ARCHIVE EXTRACTION
# usage: ex <file>
ex ()
{
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

# use emplace to sync package
# eval "$(emplace init zsh)"

neofetch | lolcat
fortune
