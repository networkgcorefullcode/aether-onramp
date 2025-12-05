# PKI Secrets Engine
module "pki_secret_engine_dev" {
  source = "../../modules/vault_pki"

  pki_path                  = "pki"
  pki_description           = "PKI secrets engine for Dev environment"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 87600

  # Root Certificate Configuration
  root_cert_config_type        = "internal"
  root_cert_config_common_name = "Dev Root CA"
  root_cert_config_ttl         = "87600h"  # 10 years
  root_cert_config_issuer_name = "dev-root-2023"

  # Issuer Configuration
  revocation_signature_algorithm = "SHA256WithRSA"

  # Role Configuration
  role_name        = "dev-pki-role"
  role_ttl         = 86400  # 24 hours
  allow_ip_sans    = true
  key_type         = "rsa"
  key_bits         = 2048
  allowed_domains  = ["dev.example.com", "*.dev.example.com"]
  allow_subdomains = true
  allow_any_name   = false

  # Config URLs
  issuing_certificates = [
    "http://vault.dev.example.com:8200/v1/pki/ca"
  ]
  crl_distribution_points = [
    "http://vault.dev.example.com:8200/v1/pki/crl"
  ]

  # Intermediate Certificate Configuration
  intermediate_pki_path             = "pki_int"
  intermediate_cert_type            = "internal"
  intermediate_common_name          = "dev.example.com Intermediate Authority"
  intermediate_issuer_common_name   = "dev-intermediate"
  intermediate_cert_format          = "pem_bundle"
  intermediate_cert_ttl             = 15480000  # Approximately 180 days
}