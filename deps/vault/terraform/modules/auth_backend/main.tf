# Terraform module for Vault auth_backend resource

resource "vault_auth_backend" "this" {
  type        = var.type
  description = var.description
  path        = var.path
  tune {
    default_lease_ttl = var.default_lease_ttl
    max_lease_ttl     = var.max_lease_ttl
  }
}