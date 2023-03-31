#!/usr/bin/env bash

set -euo pipefail

ln -sf "$1" ./colors.yml
touch alacritty.yml
