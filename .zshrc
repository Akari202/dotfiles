# ZSH settings
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt correct
bindkey -v
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit
export HISTORY_IGNORE="(ls|cd|pwd|exit|nvim|sudo reboot|history|cd -|cd ..)"


# if [ -f "/run/current-system/sw/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
#     source "/run/current-system/sw/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
# fi
#
# export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
# export ZSH_AUTOSUGGEST_STRATEGY=(history)
#
# # "Shift + Tab" to accept the whole suggestion
# bindkey '^[[Z' autosuggest-accept
# # "Right Arrow" to accept one word at a time
# bindkey '^[[C' autosuggest-forward-word


# macOS specific tasks
if [[ "$OSTYPE" =~ ^darwin ]]; then
    # Prompt
    # PROMPT="%F{#50fa7b}%n%f%F{#bd93f9}@%F{#50fa7b}akari%f %F{#bd93f9}%B%~%b%f %F{#bd93f9}%# %F{#f8f8f2}"
    PROMPT="%F{#30612f}%n%f%F{#A626A4}@%F{#30612f}akari%f %F{#A626A4}%B%~%b%f %F{#A626A4}%# %F{#383A42}"

    alias polaris="ssh -t -i /Users/ellie/.ssh/id_ed25519_polaris haradajm@polaris.clarkson.edu"
fi

# Linux specific tasks
if [[ "$OSTYPE" =~ ^linux ]]; then
    # Prompt
    # PROMPT="%F{#50fa7b}%n%f%F{#bd93f9}@%F{#50fa7b}%M%f %F{#bd93f9}%B%~%b%f %F{#bd93f9}%# %F{#f8f8f2}"
    PROMPT="%F{#30612f}%n%f%F{#A626A4}@%F{#30612f}%M%f %F{#A626A4}%B%~%b%f %F{#A626A4}%# %F{#383A42}"

    # Aliases
    alias trash="trash-put"

    # ENV variables
    # export GPG_TTY=$(tty)

    alias polaris="ssh haradajm@polaris.clarkson.edu"
    export LFS="/media/orisson"
fi

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


function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne "\e[2l\e[1 q" ;;      # Block cursor
        viins|main) echo -ne "\e[2l\e[5 q" ;; # Beam cursor
    esac
}

alias vim="nvim"
alias tree="tree -a -C -I '.git|venv|cmake-build-debug|.idea|.DS_Store|__pycache__'"
alias git-tree="git log --oneline --graph --color --all --decorate"
alias dotfiles="cd ~/dotfiles"
alias ls="uutils-ls -A --color=auto --group-directories-first"

export EDITOR=nvim
export VISUAL=neovide

eval "$(zoxide init zsh)"

compdef ls=ls
setopt complete_aliases
zle -N zle-keymap-select
precmd_functions+=()
echo -ne "\e[2l\e[5 q"
