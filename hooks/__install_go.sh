#!/usr/bin/env bash
set -euo pipefail

if ! command -v go > /dev/null 2>&1; then
    if ! command -v brew > /dev/null 2>&1; then
        echo 'Go needs to be installed from https://go.dev.'
        exit 1
    else
        echo 'Attempting to install Go from Homebrew...'
        brew install go
    fi
fi
