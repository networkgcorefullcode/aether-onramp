# Terraform module for Vault policy resource

resource "vault_policy" "this" {
  name   = var.name
  policy = var.policy
}