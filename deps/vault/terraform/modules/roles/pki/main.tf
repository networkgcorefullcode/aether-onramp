resource "vault_pki_secret_backend_role" "pki_role" {
  backend          = var.pki_backend
  name             = var.pki_role_name
  ttl              = var.pki_ttl
  allow_ip_sans    = var.pki_allow_ip_sans
  key_type         = var.pki_key_type
  key_bits         = var.pki_key_bits
  allowed_domains  = var.pki_allowed_domains
  allow_subdomains = var.pki_allow_subdomains
}
