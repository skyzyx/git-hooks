#!/usr/bin/env bash
set -euo pipefail

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
    set -x
fi

curr_dir="$(dirname "$(realpath "$0")")"

# shellcheck disable=SC1091
source "${curr_dir}/__install_go.sh"

if ! command -v go-mod-outdated > /dev/null 2>&1; then
    echo 'This check needs go-mod-outdated from https://github.com/psampaz/go-mod-outdated.'
    go install github.com/psampaz/go-mod-outdated@latest
fi

go list -u -m -json all | go-mod-outdated -update -direct -style markdown
