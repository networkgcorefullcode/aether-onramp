#!/bin/bash

# Script to backup Vault data
# Usage: ./backup_vault.sh [backup_directory]

set -e

BACKUP_DIR="${1:-./vault_backups}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_PATH="${BACKUP_DIR}/vault_backup_${TIMESTAMP}"

echo "Vault Backup Script"
echo "==================="
echo ""

# Create backup directory
mkdir -p "${BACKUP_PATH}"

# Backup vault keys
echo "Backing up vault keys..."
if [ -d "./vault_keys" ]; then
    cp -r ./vault_keys "${BACKUP_PATH}/"
    echo "✓ Vault keys backed up"
else
    echo "⚠ Warning: vault_keys directory not found"
fi

# Backup vault data (requires SSH access to vault server)
echo "Backing up vault data..."
VAULT_DATA_PATH="/opt/vault/data"
VAULT_HOST=$(grep "ansible_host" hosts.ini | head -1 | awk '{print $2}' | cut -d'=' -f2)
VAULT_USER=$(grep "ansible_user" hosts.ini | head -1 | awk '{print $3}' | cut -d'=' -f2)

if [ ! -z "${VAULT_HOST}" ] && [ ! -z "${VAULT_USER}" ]; then
    echo "Connecting to ${VAULT_USER}@${VAULT_HOST}..."
    scp -r "${VAULT_USER}@${VAULT_HOST}:${VAULT_DATA_PATH}" "${BACKUP_PATH}/vault_data" 2>/dev/null || {
        echo "⚠ Warning: Could not backup vault data directory"
    }
else
    echo "⚠ Warning: Could not determine vault host/user from hosts.ini"
fi

# Backup configuration files
echo "Backing up configuration files..."
cp -r vars "${BACKUP_PATH}/" 2>/dev/null || true
cp hosts.ini "${BACKUP_PATH}/" 2>/dev/null || true
cp Makefile "${BACKUP_PATH}/" 2>/dev/null || true

# Create backup info file
cat > "${BACKUP_PATH}/backup_info.txt" <<EOF
Vault Backup Information
========================
Backup Date: $(date)
Backup Path: ${BACKUP_PATH}
Vault Host: ${VAULT_HOST:-unknown}

Contents:
- vault_keys/     : Unseal keys and root token
- vault_data/     : Vault data directory
- vars/           : Configuration variables
- hosts.ini       : Ansible inventory
- Makefile        : Deployment commands

Restore Instructions:
1. Copy vault_keys/ back to deployment directory
2. Run 'make deploy-dev' to reinstall vault
3. Copy vault_data/ back to /opt/vault/data on vault server
4. Run 'make unseal' to unseal vault
EOF

echo ""
echo "✓ Backup completed successfully!"
echo "Backup location: ${BACKUP_PATH}"
echo ""
echo "To restore from this backup:"
echo "  1. Copy ${BACKUP_PATH}/vault_keys to ./vault_keys"
echo "  2. Run 'make deploy-dev'"
echo "  3. Copy vault data back to server"
echo "  4. Run 'make unseal'"
echo ""

# Create latest symlink
ln -sfn "${BACKUP_PATH}" "${BACKUP_DIR}/latest"
echo "Latest backup symlink: ${BACKUP_DIR}/latest"
echo ""
