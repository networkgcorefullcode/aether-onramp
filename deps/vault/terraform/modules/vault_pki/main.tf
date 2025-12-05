
module "pki_secret_engine_dev" {
    source      = "../vault_mount"

    path        = var.pki_path
    type        = "pki"
    description = var.pki_description

    default_lease_ttl_seconds = var.default_lease_ttl_seconds
    max_lease_ttl_seconds     = var.max_lease_ttl_seconds
}

module "pki_intermediate_secret_engine" {
    source      = "../vault_mount"

    path        = var.intermediate_pki_path
    type        = "pki"
    description = var.intermediate_pki_description

    default_lease_ttl_seconds = var.intermediate_default_lease_ttl_seconds
    max_lease_ttl_seconds     = var.intermediate_max_lease_ttl_seconds
}

resource "vault_pki_secret_backend_root_cert" "root_2023" {
    backend     = module.pki_secret_engine_dev.path
    type        = var.root_cert_config_type
    common_name = var.root_cert_config_common_name
    ttl         = var.root_cert_config_ttl
    issuer_name = var.root_cert_config_issuer_name
}

resource "vault_pki_secret_backend_issuer" "root_2023" {
    backend                        = module.pki_secret_engine_dev.path
    issuer_ref                     = vault_pki_secret_backend_root_cert.root_2023.issuer_id
    issuer_name                    = vault_pki_secret_backend_root_cert.root_2023.issuer_name
    revocation_signature_algorithm = var.revocation_signature_algorithm
}
resource "vault_pki_secret_backend_role" "role" {
    backend          = module.pki_secret_engine_dev.path
    name             = var.role_name
    ttl              = var.role_ttl
    allow_ip_sans    = var.allow_ip_sans
    key_type         = var.key_type
    key_bits         = var.key_bits
    allowed_domains  = var.allowed_domains
    allow_subdomains = var.allow_subdomains
    allow_any_name   = var.allow_any_name
}

resource "vault_pki_secret_backend_config_urls" "config_urls" {
    backend                 = module.pki_secret_engine_dev.path
    issuing_certificates    = var.issuing_certificates
    crl_distribution_points = var.crl_distribution_points
}

resource "vault_pki_secret_backend_intermediate_cert_request" "csr-request" {
   backend     = module.pki_intermediate_secret_engine.path
   type        = var.intermediate_cert_type
   common_name = var.intermediate_common_name
}

resource "vault_pki_secret_backend_root_sign_intermediate" "intermediate" {
   backend     = module.pki_secret_engine_dev.path
   common_name = var.intermediate_issuer_common_name
   csr         = vault_pki_secret_backend_intermediate_cert_request.csr-request.csr
   format      = var.intermediate_cert_format
   ttl         = var.intermediate_cert_ttl
   issuer_ref  = vault_pki_secret_backend_root_cert.root_2023.issuer_id
}

resource "vault_pki_secret_backend_intermediate_set_signed" "intermediate" {
   backend     = module.pki_intermediate_secret_engine.path
   certificate = vault_pki_secret_backend_root_sign_intermediate.intermediate.certificate
}