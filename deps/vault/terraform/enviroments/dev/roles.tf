# Vault Roles Configuration for Dev Environment

# Data source to get JWT auth backend configuration

# AppRole for application access
module "roles_dev" {
  source = "../../modules/roles"

  # Flags de habilitación
  enabled_approle = true
  enabled_k8s     = true
  enabled_jwt     = true
  enabled_cert    = false  # Deshabilitado hasta que exista el certificado
  enabled_pki     = false  # Deshabilitado hasta que exista el módulo PKI

  # AppRole configuration
  approle_backend          = module.auth_backend_approle.path
  approle_role_name        = "dev-app"
  approle_token_policies   = [module.policies["dev_policy"].name]
  approle_token_ttl        = 3600
  approle_token_max_ttl    = 7200

  # Kubernetes Auth configuration
  k8s_backend                          = module.auth_backend_k8s.path
  k8s_role_name                        = "dev-k8s-role"
  k8s_bound_service_account_names      = ["vault-client", "app-service-account"]
  k8s_bound_service_account_namespaces = ["default", "dev"]
  k8s_token_policies                   = [module.policies["dev_policy"].name]
  k8s_token_ttl                        = 3600

  # JWT Auth configuration
  jwt_backend         = module.auth_backend_jwt.path
  jwt_role_name       = "dev-jwt-role"
  jwt_role_type       = "jwt"
  jwt_bound_audiences = ["dev-app", "dev-service"]
  jwt_user_claim      = "sub"
  jwt_token_policies  = [module.policies["dev_policy"].name]
  jwt_token_ttl       = 3600
  
#   # Cert Auth configuration 
#   cert_backend           = module.auth_backend_cert.path
#   cert_role_name         = "dev-cert-role"
#   cert_allowed_domains   = ["dev.example.com", "*.dev.example.com"]
#   cert_allow_subdomains  = true
#   cert_certificate       = file("${path.module}/certs/ca.crt")
#   cert_token_ttl         = 3600
#   cert_token_max_ttl     = 7200
#   cert_token_policies    = [module.policies["dev_policy"].name]
  
#   # PKI Role configuration
#   pki_mount_path       = module.secrets_engine_pki.path
#   pki_role_name        = "dev-pki-role"
#   pki_ttl              = 86400
#   pki_allow_ip_sans    = true
#   pki_key_type         = "rsa"
#   pki_key_bits         = 2048
#   pki_allowed_domains  = ["dev.example.com", "*.dev.example.com"]
#   pki_allow_subdomains = true

  depends_on = [module.policies]
}

module "approles_dev_udm" {
  source = "../../modules/roles/approle"

  # AppRole configuration
  approle_backend          = module.auth_backend_approle.path
  approle_role_name        = "udm"
  approle_token_policies   = [module.policies["dev_policy"].name]
  approle_token_ttl        = 3600
  approle_token_max_ttl    = 7200
}

module "approles_dev_webconsole" {
  source = "../../modules/roles/approle"

  # AppRole configuration
  approle_backend          = module.auth_backend_approle.path
  approle_role_name        = "webconsole"
  approle_token_policies   = [module.policies["dev_policy"].name]
  approle_token_ttl        = 3600
  approle_token_max_ttl    = 7200
}