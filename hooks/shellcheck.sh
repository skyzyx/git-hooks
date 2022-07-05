#!/usr/bin/env bash
set -euo pipefail

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
    set -x
fi

if ! command -v shellcheck > /dev/null 2>&1; then
    if ! command -v brew > /dev/null 2>&1; then
        echo 'shellcheck needs to be installed from https://github.com/koalaman/shellcheck.'
        exit 1
    else
        echo 'Attempting to install shellcheck from Homebrew...'
        brew install shellcheck
    fi
fi

shellcheck "$@"
