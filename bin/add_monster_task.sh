#!/usr/bin/env -S bash -euo pipefail

function main {
    local text="$*"

    [[ -n $text ]] \
        || { echo "Usage: $0 <task text>" >&2; exit 1; }

    while IFS= read -r name; do
        ensure_in_index "$name"
        ensure_task_file "$name"
        local task="${text//\{name\}/$name}"
        next -a "tasks/monsters/$name.md" "$task"
    done < <(find_monsters)
}

function find_monsters {
    for monster in Monsters/*.md; do
        basename "$monster" .md
    done
}

function ensure_in_index {
    local name="$1"
    local index="tasks/monsters/_index.md"

    grep -qF "@include $name.md" "$index" \
        && return
    printf '@include %s.md\n' "$name" \
        >> "$index"
}

function ensure_task_file {
    local name="$1"
    local file="tasks/monsters/$name.md"

    [[ -f $file ]] \
        && return
    cat > "$file" <<EOF
@notnext

EOF
}

main "$@"
