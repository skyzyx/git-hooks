#!/usr/bin/env bash
set -euo pipefail

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
    set -x
fi

if ! command -v shfmt > /dev/null 2>&1; then
    echo 'This check needs shfmt from https://github.com/mvdan/sh/releases'
    exit 1
fi

shfmt "$@"
