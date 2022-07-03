#!/usr/bin/env bash
set -euo pipefail

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
    set -x
fi

printf '%q\n' "${PWD##*/}"
curr_dir=${PWD##*/}     # to assign to a variable
curr_dir=${curr_dir:-/} # to correct for the case where PWD=/

# shellcheck disable=SC1091
source "${curr_dir}/__install_go.sh"

if ! command -v gofumpt > /dev/null 2>&1; then
    echo 'This check needs gofumpt from https://github.com/mvdan/gofumpt.'
    go install mvdan.cc/gofumpt@latest
fi

gofumpt "$@"
