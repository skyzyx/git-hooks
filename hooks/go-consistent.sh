#!/usr/bin/env bash
set -euo pipefail

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
    set -x
fi

curr_dir="$(dirname "$(realpath "$0")")"

# shellcheck disable=SC1091
source "${curr_dir}/__install_go.sh"

if ! command -v go-consistent > /dev/null 2>&1; then
    echo 'This check needs go-consistent from https://github.com/quasilyte/go-consistent.'
    go install github.com/quasilyte/go-consistent@latest
fi

go-consistent -v ./...
