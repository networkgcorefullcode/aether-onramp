#!/bin/bash

# Script to get the correct checksum for Vault version
# This helps update the vault_checksum in defaults/main.yml and vars/main.yml

VAULT_VERSION="${1:-1.15.0}"

echo "Getting SHA256 checksum for Vault ${VAULT_VERSION}..."
echo ""

# Download the checksums file
CHECKSUMS_URL="https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_SHA256SUMS"

echo "Downloading checksums from:"
echo "${CHECKSUMS_URL}"
echo ""

# Fetch and parse
curl -s "${CHECKSUMS_URL}" | grep "linux_amd64.zip" || {
    echo "Error: Could not fetch checksums for version ${VAULT_VERSION}"
    echo ""
    echo "Available versions can be found at:"
    echo "https://releases.hashicorp.com/vault/"
    exit 1
}

echo ""
echo "To update your configuration, copy the checksum above and update:"
echo "  - vars/main.yml"
echo "  - roles/deploy_dev/defaults/main.yml"
echo ""
echo "Format: sha256:<checksum>"
echo ""
