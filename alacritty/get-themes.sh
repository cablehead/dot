#!/usr/bin/env bash

set -euo pipefail

xa() {
    xargs -I{} "$@"
}

~/session/0398WU8CZ26QOMEGDUD3GXVSK/github-repo-tarball alacritty/alacritty-theme |
    xa curl -s -L {} |
    gunzip -c |
    tar xvf - --strip-components=1 ./alacritty-theme-master/themes
