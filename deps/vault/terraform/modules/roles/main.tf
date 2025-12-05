# App Role for application access

locals {
    enabled_approle  = var.enabled_approle
    enabled_k8s      = var.enabled_k8s
    enabled_jwt      = var.enabled_jwt
    enabled_cert     = var.enabled_cert
    enabled_pki      = var.enabled_pki
}

resource "vault_approle_auth_backend_role" "app_role" {
  backend   = var.approle_backend
  role_name = var.approle_role_name

  token_policies = var.approle_token_policies
  token_ttl      = var.approle_token_ttl
  token_max_ttl  = var.approle_token_max_ttl
  count          = local.enabled_approle ? 1 : 0
}

resource "vault_kubernetes_auth_backend_role" "k8s_role" {
  backend                          = var.k8s_backend
  role_name                        = var.k8s_role_name
  bound_service_account_names      = var.k8s_bound_service_account_names
  bound_service_account_namespaces = var.k8s_bound_service_account_namespaces
  token_policies                   = var.k8s_token_policies
  token_ttl                        = var.k8s_token_ttl

  count = local.enabled_k8s ? 1 : 0
}

resource "vault_jwt_auth_backend_role" "jwt_role" {
  backend         = var.jwt_backend
  role_name       = var.jwt_role_name
  role_type       = var.jwt_role_type
  bound_audiences = var.jwt_bound_audiences
  user_claim      = var.jwt_user_claim
  token_policies  = var.jwt_token_policies
  token_ttl       = var.jwt_token_ttl

  count = local.enabled_jwt ? 1 : 0
}

resource "vault_cert_auth_backend_role" "cert_role" {
  backend = var.cert_backend
  name    = var.cert_role_name
  
  certificate = var.cert_certificate
  allowed_names  = var.cert_allowed_domains
  
  token_ttl      = var.cert_token_ttl
  token_max_ttl  = var.cert_token_max_ttl

  count = local.enabled_cert ? 1 : 0
}

resource "vault_pki_secret_backend_role" "pki_role" {
  backend          = var.pki_mount_path != null ? var.pki_mount_path : var.pki_backend
  name             = var.pki_role_name
  ttl              = var.pki_ttl
  allow_ip_sans    = var.pki_allow_ip_sans
  key_type         = var.pki_key_type
  key_bits         = var.pki_key_bits
  allowed_domains  = var.pki_allowed_domains
  allow_subdomains = var.pki_allow_subdomains
  
  count = local.enabled_pki ? 1 : 0
}