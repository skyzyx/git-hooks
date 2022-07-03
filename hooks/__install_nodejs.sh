#!/usr/bin/env bash
set -euo pipefail

if ! command -v node > /dev/null 2>&1; then
    if ! command -v brew > /dev/null 2>&1; then
        echo 'Attempting to install Node.js from Homebrew...'
        brew install node
    else
        echo 'Node.js needs to be installed from https://nodejs.org.'
        exit 1
    fi
fi
