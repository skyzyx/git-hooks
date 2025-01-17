#!/usr/bin/env bash
set -euo pipefail

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
    set -x
fi

if ! command -v golangci-lint > /dev/null 2>&1; then
    if ! command -v brew > /dev/null 2>&1; then
        echo 'golangci-lint needs to be installed from https://github.com/golangci/golangci-lint.'
        exit 1
    else
        echo 'Attempting to install golangci-lint from Homebrew...'
        brew install golangci/tap/golangci-lint
    fi
fi

# 1. Find all .go files.
# 2. Find the directories of each of the .go files.
# 3. Run golangci-lint on each of the directories.
# 4. But only process a directory once.
find "$PWD" -type f -name "*.go" -print0 |
    xargs -0 -I% dirname "%" |
    uniq |
    xargs -I% bash -c 'cd "%" && golangci-lint run --fix *.go'
