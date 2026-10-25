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

# Copy a file's content or a tree of a directory to clipboard
clip() {
    if [ -z "$1" ]; then
        echo "Usage: clip <file_or_directory>"
        return 1
    fi

    local target="$1"
    local copy_cmd=""

    if [[ "$OSTYPE" =~ ^darwin ]]; then
        copy_cmd="pbcopy"
    else
        echo "Error: unsupported operating system"
        return 1
    fi

    if [ -f "$target" ]; then
        cat "$target" | eval "$copy_cmd"
        echo "File '$target' copied to clipboard"

    elif [ -d "$target" ]; then
        tree -a -C -I '.git' -L 5 --filelimit 8 "$target" | eval "$copy_cmd"
        echo "Directory structure for '$target' copied to clipboard (Depth: 5, Max Files/Dir: 8)"

    else
        echo "Error: '$target' is not a valid target"
        return 1
    fi
}

# Disconnect and reconnect mullvad before and after SSH
kmssh() {
    if [[ -z "$1" ]]; then
        echo "Error ssh destination not specified"
        return 1
    fi

    echo "Disconnecting Mullvad VPN for SSH connection to $1"
    echo "Disconnecting in 3 seconds"
    sleep 1
    echo "Disconnecting in 2 seconds"
    sleep 1
    echo "Disconnecting in 1 seconds"
    sleep 1
    echo "Disconnecting now"
    mullvad disconnect
    sleep 1

    {
        kitten ssh "$@"
    } always {
        echo "Reconnecting Mullvad VPN"
        mullvad connect
    }
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

