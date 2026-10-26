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
