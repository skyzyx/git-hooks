#!/usr/bin/env bash
set -euo pipefail

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
    set -x
fi

if ! command -v checkov > /dev/null 2>&1; then
    echo 'Attempting to install checkov from Pypi...'
    pip3 install checkov
fi

checkov --config-file .checkov.yml
