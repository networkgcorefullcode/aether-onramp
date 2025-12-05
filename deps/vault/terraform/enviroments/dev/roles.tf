# Vault Roles Configuration for Dev Environment

# AppRole for application access
module "approle" {
  source = "../../modules/roles"

  # AppRole configuration
  approle_backend          = "approle"
  approle_role_name        = "dev-app"
  approle_token_policies   = [module.policies["dev_policy"].name, module.policies["default"].name]
  approle_token_ttl        = 3600
  approle_token_max_ttl    = 7200

  # Kubernetes Auth configuration
  k8s_backend                          = "kubernetes"
  k8s_role_name                        = "dev-k8s-role"
  k8s_bound_service_account_names      = ["vault-client", "app-service-account"]
  k8s_bound_service_account_namespaces = ["default", "dev"]
  k8s_token_policies                   = [module.policies["dev_policy"].name, module.policies["default"].name]
  k8s_token_ttl                        = 3600

  # JWT Auth configuration
  jwt_backend         = "jwt"
  jwt_role_name       = "dev-jwt-role"
  jwt_role_type       = "jwt"
  jwt_bound_audiences = ["dev-app", "dev-service"]
  jwt_user_claim      = "sub"
  jwt_token_policies  = [module.policies["dev_policy"].name, module.policies["default"].name]
  jwt_token_ttl       = 3600

  # PKI Role configuration
  pki_backend          = "pki"
  pki_role_name        = "dev-cert-role"
  pki_allowed_domains  = ["dev.example.com", "*.dev.example.com"]
  pki_allow_subdomains = true
  pki_max_ttl          = 86400

  depends_on = [module.policies]
}

# Additional AppRole for test environment access
module "test_approle" {
  source = "../../modules/roles"

  # AppRole configuration
  approle_backend          = "approle"
  approle_role_name        = "test-app"
  approle_token_policies   = [module.policies["test_policy"].name, module.policies["default"].name]
  approle_token_ttl        = 3600
  approle_token_max_ttl    = 7200

  # Kubernetes Auth configuration
  k8s_backend                          = "kubernetes"
  k8s_role_name                        = "test-k8s-role"
  k8s_bound_service_account_names      = ["vault-client"]
  k8s_bound_service_account_namespaces = ["test"]
  k8s_token_policies                   = [module.policies["test_policy"].name, module.policies["default"].name]
  k8s_token_ttl                        = 3600

  # JWT Auth configuration
  jwt_backend         = "jwt"
  jwt_role_name       = "test-jwt-role"
  jwt_role_type       = "jwt"
  jwt_bound_audiences = ["test-app"]
  jwt_user_claim      = "sub"
  jwt_token_policies  = [module.policies["test_policy"].name, module.policies["default"].name]
  jwt_token_ttl       = 3600

  # PKI Role configuration
  pki_backend          = "pki"
  pki_role_name        = "test-cert-role"
  pki_allowed_domains  = ["test.example.com"]
  pki_allow_subdomains = true
  pki_max_ttl          = 86400

  depends_on = [module.policies]
}

# Admin AppRole for management operations
module "admin_approle" {
  source = "../../modules/roles"

  # AppRole configuration
  approle_backend          = "approle"
  approle_role_name        = "admin-app"
  approle_token_policies   = [module.policies["admin_policy"].name, module.policies["management_policy"].name]
  approle_token_ttl        = 7200
  approle_token_max_ttl    = 14400

  # Kubernetes Auth configuration
  k8s_backend                          = "kubernetes"
  k8s_role_name                        = "admin-k8s-role"
  k8s_bound_service_account_names      = ["vault-admin"]
  k8s_bound_service_account_namespaces = ["vault", "kube-system"]
  k8s_token_policies                   = [module.policies["admin_policy"].name]
  k8s_token_ttl                        = 7200

  # JWT Auth configuration
  jwt_backend         = "jwt"
  jwt_role_name       = "admin-jwt-role"
  jwt_role_type       = "jwt"
  jwt_bound_audiences = ["admin-console"]
  jwt_user_claim      = "sub"
  jwt_token_policies  = [module.policies["admin_policy"].name]
  jwt_token_ttl       = 7200

  # PKI Role configuration
  pki_backend          = "pki"
  pki_role_name        = "admin-cert-role"
  pki_allowed_domains  = ["admin.example.com", "*.admin.example.com"]
  pki_allow_subdomains = true
  pki_max_ttl          = 172800

  depends_on = [module.policies]
}
