module "auth_backend_cert" {
  source = "../../modules/auth_backend"

  type              = "cert"
  description       = "Development environment auth backend for cert"
  path              = "auth-dev-cert"
  default_lease_ttl = "3600s"
  max_lease_ttl     = "7200s"
}