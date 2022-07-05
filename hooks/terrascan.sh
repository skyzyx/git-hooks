#!/usr/bin/env bash
set -euo pipefail

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
    set -x
fi

if ! command -v terrascan > /dev/null 2>&1; then
    if ! command -v brew > /dev/null 2>&1; then
        echo 'terrascan needs to be installed from https://github.com/tenable/terrascan.'
        exit 1
    else
        echo 'Attempting to install terrascan from Homebrew...'
        brew install terrascan
    fi
fi

terrascan scan "$@"
