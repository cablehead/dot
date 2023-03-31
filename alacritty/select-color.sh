#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"

xa() {
    xargs -I{} "$@"
}

usage() {
    echo "Usage: $0 dark|light" >&2
    exit 1
}

if [[ $# -ne 1 ]]; then usage; fi

MODE="$1"

if [[ "$MODE" != "dark" && "$MODE" != "light" ]]; then usage; fi

find -s $MODE -type l |
    fzf --layout reverse-list \
        --border none \
        --no-info \
        --color fg+:black,bg+:white,gutter:-1,pointer:green,prompt:blue,hl+:green \
        --preview "bash -c './set-color.sh {} ; bat --color always {}'" \
        --preview-window border-none >> selected
