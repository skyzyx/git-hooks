#!/usr/bin/env bash
set -euo pipefail

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
    set -x
fi

curr_dir="$(dirname "$(realpath "$0")")"

# shellcheck disable=SC1091
source "${curr_dir}/__install_go.sh"

if ! command -v goconst > /dev/null 2>&1; then
    echo 'This check needs goconst from https://github.com/jgautheron/goconst.'
    go install github.com/jgautheron/goconst/cmd/goconst@latest
fi

goconst -match-constant -numbers ./...
