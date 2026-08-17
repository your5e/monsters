#!/usr/bin/env -S bash -euo pipefail

ibooks="$HOME/Library/Mobile Documents/iCloud~com~apple~iBooks/Documents"

pdfs=(
    # open content
    "$ibooks/SRD_CC_v51.pdf"
    "$ibooks/Black Flag Reference Document 2025-07-01.pdf"
    "$ibooks/A5ESRD Monsters A-F.pdf"
    "$ibooks/A5ESRD Monsters G-Z.pdf"
    "$ibooks/The_System_Reference_Document_for_3.pdf"

    # D&D 1e
    "$ibooks/Monster Manual 2 (1e).pdf"

    # D&D 2e
    "$ibooks/Monstrous Manual (2e).pdf"

    # D&D 3.5e
    "$ibooks/Monster Manual I (3.5e).pdf"
    "$ibooks/Monster Manual II (3.5e).pdf"
    "$ibooks/Monster Manual III (3.5e).pdf"
    "$ibooks/Monster Manual IV (3.5e).pdf"
    "$ibooks/Monster Manual V (3.5e).pdf"

    # D&D 4e
    "$ibooks/Monster Manual (4e).pdf"
    "$ibooks/Monster Manual 2 (4e).pdf"
    "$ibooks/Monster Manual 3 (4e).pdf"

    # D&D 5e
    "$ibooks/Monster Manual (5e 2014).pdf"
    "$ibooks/Monster Manual (5.5e 2024).pdf"

    # level up advanced 5e
    "$ibooks/Monstrous Menagerie (Level Up).pdf"

    # tales of the valiant
    "$ibooks/Monster Vault (ToV).pdf"
)

for pdf in "${pdfs[@]}"; do
    read -r -n1 -p "open $(basename "$pdf")? y/n " reply
    echo
    [[ $reply == [Yy] ]] && open "$pdf"
done

exit 0
