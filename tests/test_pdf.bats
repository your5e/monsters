bats_require_minimum_version 1.7.0

setup_file() {
    build="$BATS_FILE_TMPDIR/build"
    python bin/build_html.py tests/index.toml "$build"
    make render DIR="$build"

    pdf="$build/monsters.pdf"
    pdftotext "$pdf" "$BATS_FILE_TMPDIR/text.txt"
    pdffonts "$pdf" > "$BATS_FILE_TMPDIR/fonts.txt"
    pdfimages -list "$pdf" > "$BATS_FILE_TMPDIR/images.txt"
    export EXTRACTED="$BATS_FILE_TMPDIR"
}

@test "renders the content" {
    grep -q "Aboleth" "$EXTRACTED/text.txt"
}

@test "embeds the artwork" {
    grep -qw "image" "$EXTRACTED/images.txt"
}

@test "uses the fonts" {
    grep -q "Lora" "$EXTRACTED/fonts.txt"
    grep -q "Lora-Bold" "$EXTRACTED/fonts.txt"
    grep -q "Lora-Italic" "$EXTRACTED/fonts.txt"
    grep -q "Lora-Bold-Italic" "$EXTRACTED/fonts.txt"
}
