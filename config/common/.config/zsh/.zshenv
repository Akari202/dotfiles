export EDITOR=nvim

# Run a command natively or fallback to typst
run_cmd() {
    local cmd="$1"
    shift

    if command -v "$cmd" &> /dev/null; then
        echo "Using native $cmd" >&2
        "$cmd" "$@"
    elif command -v nix &> /dev/null; then
        echo "Using $cmd in a nix shell" >&2
        nix shell "nixpkgs#${cmd}" -c "$cmd" "$@"
    else
        echo "Error: Required command '$cmd' is not installed, and 'nix' is unavailable." >&2
        if [[ $SHOULD_ERROR -ne 0 ]]; then
            exit $SHOULD_ERROR
        fi
    fi
}

if [ -d "$ZDOTDIR/env" ]; then
    source "$ZDOTDIR/env/*.zsh"
fi
