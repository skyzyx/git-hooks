#!/usr/bin/env bash
set -euo pipefail

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
    set -x
fi

if ! command -v shfmt > /dev/null 2>&1; then
    if ! command -v brew > /dev/null 2>&1; then
        echo 'shfmt needs to be installed from https://github.com/mvdan/sh/releases.'
        exit 1
    else
        echo 'Attempting to install shfmt from Homebrew...'
        brew install shfmt
    fi
fi

shfmt "$@"
