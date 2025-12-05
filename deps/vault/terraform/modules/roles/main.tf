# App Role for application access

resource "vault_approle_auth_backend_role" "app_role" {
  backend   = var.approle_backend
  role_name = var.approle_role_name

  token_policies = var.approle_token_policies
  token_ttl      = var.approle_token_ttl
  token_max_ttl  = var.approle_token_max_ttl
}

resource "vault_approle_auth_backend_role_id" "app_role_id" {
  backend   = var.approle_backend
  role_name = vault_approle_auth_backend_role.app_role.role_name
}

resource "vault_approle_auth_backend_secret_id" "app_secret_id" {
  backend   = var.approle_backend
  role_name = vault_approle_auth_backend_role.app_role.role_name
}

resource "vault_kubernetes_auth_backend_role" "k8s_role" {
  backend                          = var.k8s_backend
  role_name                        = var.k8s_role_name
  bound_service_account_names      = var.k8s_bound_service_account_names
  bound_service_account_namespaces = var.k8s_bound_service_account_namespaces
  token_policies                   = var.k8s_token_policies
  token_ttl                        = var.k8s_token_ttl
}

resource "vault_jwt_auth_backend_role" "jwt_role" {
  backend         = var.jwt_backend
  role_name       = var.jwt_role_name
  role_type       = var.jwt_role_type
  bound_audiences = var.jwt_bound_audiences
  user_claim      = var.jwt_user_claim
  token_policies  = var.jwt_token_policies
  token_ttl       = var.jwt_token_ttl
}

resource "vault_pki_secret_backend_role" "pki_role" {
  backend = var.pki_backend
  name    = var.pki_role_name

  allowed_domains  = var.pki_allowed_domains
  allow_subdomains = var.pki_allow_subdomains
  max_ttl          = var.pki_max_ttl
}