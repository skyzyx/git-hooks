#!/usr/bin/env bash
set -euo pipefail

EMPTY_COMMIT="$(git hash-object -t tree /dev/null)"
readonly EMPTY_COMMIT

# Report errors based on git configuration.
# Respect overrides in .gitattributes if present.
git diff-index --check "${EMPTY_COMMIT}"
