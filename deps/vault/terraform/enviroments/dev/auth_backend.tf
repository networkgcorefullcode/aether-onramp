# Main Terraform configuration for the dev environment

module "auth_backend" {
  source = "../../modules/auth_backend"

  type              = "userpass"
  description       = "Development environment auth backend"
  path              = "auth-dev"
  default_lease_ttl = "3600s"
  max_lease_ttl     = "7200s"
}

module "auth_backend_k8s" {
  source = "../../modules/auth_backend"

  type              = "kubernetes"
  description       = "Development environment auth backend for kubernetes"
  path              = "auth-dev-k8s"
  default_lease_ttl = "3600s"
  max_lease_ttl     = "7200s"
}

module "auth_backend_approle" {
  source = "../../modules/auth_backend"

  type              = "approle"
  description       = "Development environment auth backend for approle"
  path              = "auth-dev-approle"
  default_lease_ttl = "3600s"
  max_lease_ttl     = "7200s"
}

module "auth_backend_jwt" {
  source = "../../modules/auth_backend"

  type              = "jwt"
  description       = "Development environment auth backend for jwt"
  path              = "auth-dev-jwt"
  default_lease_ttl = "3600s"
  max_lease_ttl     = "7200s"
}

module "auth_backend_cert" {
  source = "../../modules/auth_backend"

  type              = "cert"
  description       = "Development environment auth backend for cert"
  path              = "auth-dev-cert"
  default_lease_ttl = "3600s"
  max_lease_ttl     = "7200s"
}