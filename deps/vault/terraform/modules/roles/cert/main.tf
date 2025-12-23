resource "vault_cert_auth_backend_role" "cert_role" {
  backend = var.cert_backend
  name    = var.cert_role_name
  
  certificate    = var.cert_certificate
  allowed_names  = var.cert_allowed_domains
  
  token_ttl      = var.cert_token_ttl
  token_max_ttl  = var.cert_token_max_ttl
  token_policies = var.cert_token_policies
}
