#!/usr/bin/env bash
set -euo pipefail

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
    set -x
fi

curr_dir="$(dirname "$(realpath "$0")")"

if ! command -v tfsec > /dev/null 2>&1; then
    if ! command -v brew > /dev/null 2>&1; then
        echo 'tfsec needs to be installed from https://github.com/aquasecurity/tfsec.'
        exit 1
    else
        echo 'Attempting to install tfsec from Homebrew...'
        brew install tfsec
    fi
fi

find "$PWD" -type f -name "*.tf" -print0 |
    xargs -0 -I% dirname "%" |
    uniq |
    xargs -I% bash -c 'cd "%" && tfsec --concise-output --config-file "'"${curr_dir}"'/.tfsec.yml" --exclude-downloaded-modules --force-all-dirs .'
