# Extract archive
ex () {
    if [ -z "$1" ]; then
        echo "Usage: ex <file>"
        return 1
    fi
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

# Make and enter a director
mz () {
    if [ -z "$1" ]; then
        echo "Usage: mz <directory_name>"
        return 1
    fi

    mkdir $1
    cd ./$1
}

# Set cursor depending on mode
zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne "\e[2l\e[1 q" ;;      # Block cursor
        viins|main) echo -ne "\e[2l\e[5 q" ;; # Beam cursor
    esac
}

# Make <C-z> reopen background jobs
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}

