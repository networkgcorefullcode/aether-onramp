resource "vault_approle_auth_backend_role" "app_role" {
  backend   = var.approle_backend
  role_name = var.approle_role_name

  token_policies = var.approle_token_policies
  token_ttl      = var.approle_token_ttl
  token_max_ttl  = var.approle_token_max_ttl
}

resource "vault_approle_auth_backend_role_secret_id" "secret_id" {
  backend   = var.approle_backend
  role_name = vault_approle_auth_backend_role.app_role.role_name

  metadata = jsonencode(var.approle_secret_id_metadata)
}