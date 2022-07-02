#!/usr/bin/env bash
set -euo pipefail

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
    set -x
fi

if ! command -v yapf > /dev/null 2>&1; then
    echo 'This check needs yapf from https://github.com/google/yapf'
    exit 1
fi

yapf --in-place --recursive "$0"
