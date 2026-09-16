# Run a command natively or fallback to typst
run_cmd() {
    local cmd="$1"
    shift

    if command -v "$cmd" &> /dev/null; then
        echo "Using native $cmd"
        "$cmd" "$@"
    elif command -v nix &> /dev/null; then
        echo "Using $cmd in a nix shell"
        nix shell "nixpkgs#${cmd}" -c "$cmd" "$@"
    else
        echo "Error: Required command '$cmd' is not installed, and 'nix' is unavailable." >&2
        if [[ $SHOULD_ERROR -ne 0 ]]; then
            exit $SHOULD_ERROR
        fi
    fi
}

# Compile a typst document to pdf and html
compile_typst() {
    local filename="$1"
    shift

    echo "Compiling $filename PDF"
    run_cmd typst compile --input "compile-host=cli" --input "now=$(date '+%Y %m %d %H %M %S')" "$@" "$filename"
    echo "Compiling $filename HTML"
    run_cmd typst compile --format html --features html --pretty --diagnostic-format short --input "compile-host=didactic" --input "now=$(date '+%Y %m %d %H %M %S')" "$@" "$filename"
}

# Watch a typst document to pdf
watch_typst() {
    local filename="$1"
    shift

    echo "Watching $filename PDF"
    run_cmd typst watch --input "compile-host=cli" --input "now=$(date '+%Y %m %d %H %M %S')" "$@" "$filename"
}
