#!/usr/bin/env bash
set -euo pipefail

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
    set -x
fi

if ! command -v shellcheck > /dev/null 2>&1; then
    echo 'This check needs shellcheck from https://github.com/koalaman/shellcheck'
    exit 1
fi

shellcheck "$@"
