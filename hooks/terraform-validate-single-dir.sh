#!/usr/bin/env bash
set -euo pipefail

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
    set -x
fi

if ! command -v terraform > /dev/null 2>&1; then
    if ! command -v tfswitch > /dev/null 2>&1; then
        if ! command -v brew > /dev/null 2>&1; then
            echo 'tfswitch needs to be installed from https://github.com/warrensbox/terraform-switcher.'
            exit 1
        else
            echo 'Attempting to install tfswitch from Homebrew...'
            brew install warrensbox/tap/tfswitch
        fi
    else
        echo 'Attempting to install Terraform using tfswitch...'
        tfswitch
    fi
fi

# Clean all .terraform/ directories. They conflict with running tflint.
# shellcheck disable=2038
find "$PWD" -type d -name ".terraform" | xargs rm -Rf

# Initialize Terraform.
terraform init

# Run over the whole directory.
terraform validate
