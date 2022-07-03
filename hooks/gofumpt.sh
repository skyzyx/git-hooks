#!/usr/bin/env bash
set -euo pipefail

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
    set -x
fi

curr_dir="$(basename "$(realpath "$0")")"

# shellcheck disable=SC1091
source "${curr_dir}/__install_go.sh"

if ! command -v gofumpt > /dev/null 2>&1; then
    echo 'This check needs gofumpt from https://github.com/mvdan/gofumpt.'
    go install mvdan.cc/gofumpt@latest
fi

gofumpt "$@"
