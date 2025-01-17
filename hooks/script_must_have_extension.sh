#!/usr/bin/env bash
set -euo pipefail

declare -i RC=0

has_sh_extension() {
    [[ "$(basename "${1}")" != "$(basename "${1}" .sh)" ]]
}

for filename in "${@}"; do
    if has_sh_extension "${filename}"; then
        echo "[OK]    ${filename}"
    else
        echo "[ERROR] ${filename} lacks the required .sh extension"
        RC=1
    fi
done

exit $RC
