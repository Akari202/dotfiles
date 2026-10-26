# Compile a typst document to pdf and html
compile_typst() {
    local filename="$1"
    shift

    echo "Compiling $filename PDF"
    run_cmd typst compile --input "compile-host=cli" --input "now=$(date '+%Y %m %d %H %M %S')" "$@" "$filename"
    echo "Compiling $filename HTML"
    run_cmd typst compile --format html --features html --pretty --diagnostic-format short --input "compile-host=didactic" --input "grades=false" --input "now=$(date '+%Y %m %d %H %M %S')" "$@" "$filename"
}

# Compile a typst document to pdf
compile_typst_pdf() {
    local filename="$1"
    shift

    echo "Compiling $filename PDF"
    run_cmd typst compile --input "compile-host=cli" --input "now=$(date '+%Y %m %d %H %M %S')" "$@" "$filename"
}

# Watch a typst document to pdf
watch_typst() {
    local filename="$1"
    shift

    echo "Watching $filename PDF"
    run_cmd typst watch --input "compile-host=cli" --input "now=$(date '+%Y %m %d %H %M %S')" "$@" "$filename"
}
