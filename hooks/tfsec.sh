#!/usr/bin/env bash
set -euo pipefail

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
    set -x
fi

if ! command -v tfsec > /dev/null 2>&1; then
    if ! command -v brew > /dev/null 2>&1; then
        echo 'tfsec needs to be installed from https://github.com/aquasecurity/tfsec.'
        exit 1
    else
        echo 'Attempting to install tfsec from Homebrew...'
        brew install tfsec
    fi
fi

echo "$(realpath .)"
tfsec --concise-output --config-file .tfsec.yml --exclude-downloaded-modules "$PWD"
