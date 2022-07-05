#!/usr/bin/env bash
set -euo pipefail

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
    set -x
fi

curr_dir="$(dirname "$(realpath "$0")")"

if ! command -v tflint > /dev/null 2>&1; then
    if ! command -v brew > /dev/null 2>&1; then
        echo 'Attempting to install tflint from Homebrew...'
        brew install tflint
    else
        echo 'tflint needs to be installed from https://github.com/terraform-linters/tflint.'
        exit 1
    fi
fi

# Clean all .terraform/ directories. They conflict with running tflint.
# shellcheck disable=2038
find "$PWD" -type d -name ".terraform" | xargs rm -Rf

# Initialize tflint.
GITHUB_TOKEN="" tflint --init

# 1. Find all .tf files.
# 2. Find the directories of each of the .tf files.
# 3. Run tflint on each of the directories.
# 4. But only process a directory once.
find "$PWD" -type f \( -name "*.tf" -or -name "*.tfvars" \) -print0 |
    xargs -0 -I% dirname "%" |
    uniq |
    xargs -I% bash -c 'cd "%" && terraform init && tflint --config="'"${curr_dir}"'/.tflint.hcl" .'
