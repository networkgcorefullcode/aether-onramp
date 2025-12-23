#!/bin/bash

# Script to populate Vault with example secrets
# Usage: ./populate_vault.sh

set -e

# Vault configuration
export VAULT_ADDR="${VAULT_ADDR:-http://127.0.0.1:8200}"
VAULT_KEYS_DIR="${VAULT_KEYS_DIR:-./vault_keys}"

# Check if vault is available
if ! command -v vault &> /dev/null; then
    echo "Error: vault CLI not found. Please install vault first."
    exit 1
fi

# Check if root token exists
if [ ! -f "${VAULT_KEYS_DIR}/root_token/rootkey" ]; then
    echo "Error: Root token not found at ${VAULT_KEYS_DIR}/root_token/rootkey"
    echo "Please run 'make deploy-dev' first to initialize Vault."
    exit 1
fi

# Set vault token
export VAULT_TOKEN=$(cat "${VAULT_KEYS_DIR}/root_token/rootkey")

echo "Vault Address: ${VAULT_ADDR}"
echo "Authenticating with root token..."

# Check vault status
if ! vault status &> /dev/null; then
    echo "Error: Cannot connect to Vault. Is it running and unsealed?"
    exit 1
fi

echo "✓ Connected to Vault successfully"

# Enable KV v2 secrets engine if not already enabled
echo "Enabling KV v2 secrets engine..."
vault secrets enable -path=secret kv-v2 2>/dev/null || echo "KV v2 already enabled at secret/"

# Database credentials
echo "Writing database credentials..."
vault kv put secret/database/postgresql \
    host=db.example.com \
    port=5432 \
    username=app_user \
    password=SecurePassword123 \
    database=app_db

vault kv put secret/database/mysql \
    host=mysql.example.com \
    port=3306 \
    username=app_user \
    password=SecurePassword456 \
    database=app_db

# Application secrets
echo "Writing application secrets..."
vault kv put secret/app/config \
    jwt_secret=$(openssl rand -base64 32) \
    encryption_key=$(openssl rand -base64 32) \
    session_secret=$(openssl rand -base64 32)

# API Keys (example - replace with real values)
echo "Writing API keys..."
vault kv put secret/api_keys \
    github_token=ghp_example_token_12345 \
    stripe_api_key=sk_test_example_12345

# Cloud provider credentials (example - replace with real values)
echo "Writing cloud credentials..."
vault kv put secret/cloud/aws \
    access_key=AKIAEXAMPLE12345 \
    secret_key=exampleSecretKey12345 \
    region=us-east-1

# Kubernetes secrets
echo "Writing kubernetes secrets..."
vault kv put secret/kubernetes \
    admin_token=$(openssl rand -base64 32) \
    service_account_key=$(openssl rand -base64 32)

# SMTP credentials
echo "Writing SMTP credentials..."
vault kv put secret/smtp \
    host=smtp.gmail.com \
    port=587 \
    username=noreply@example.com \
    password=EmailPassword123

echo ""
echo "✓ All secrets written successfully!"
echo ""
echo "To read secrets, use:"
echo "  vault kv get secret/database/postgresql"
echo "  vault kv get secret/app/config"
echo ""
echo "To list all secrets:"
echo "  vault kv list secret/"
echo ""
