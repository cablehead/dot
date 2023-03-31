#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"

zellij action new-pane -cf -n "Select Theme" -- ./select-color.sh dark
