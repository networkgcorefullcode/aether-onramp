module "auth_backend_approle" {
  source = "../../modules/auth_backend"

  type              = "approle"
  description       = "Development environment auth backend for approle"
  path              = "auth-dev-approle"
  default_lease_ttl = "3600s"
  max_lease_ttl     = "7200s"
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