module "auth_backend_jwt" {
  source = "../../modules/auth_backend"

  type              = "jwt"
  description       = "Development environment auth backend for jwt"
  path              = "auth-dev-jwt"
  default_lease_ttl = "3600s"
  max_lease_ttl     = "7200s"
}