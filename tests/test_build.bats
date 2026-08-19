bats_require_minimum_version 1.7.0

setup_file() {
    export BUILD="$BATS_FILE_TMPDIR/build"
    python bin/build_html.py tests/index.toml "$BUILD"
    export HTML="$BUILD/monsters.html"
}

@test "renders the monster name" {
    grep -q "Aboleth" "$HTML"
}

@test "renders the armour class" {
    grep -q "<strong>AC</strong> 17" "$HTML"
}

@test "renders a feature" {
    grep -q "Amphibious" "$HTML"
}

@test "strips wikilinks" {
    ! grep -q '\[\[' "$HTML"
}

@test "references the artwork" {
    grep -q "/images/Aboleth.png" "$HTML"
}

@test "copies the artwork" {
    [ -f "$BUILD/images/Aboleth.png" ]
}

@test "copies the font" {
    [ -f "$BUILD/assets/Lora.ttf" ]
}
