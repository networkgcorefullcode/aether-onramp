# Main Terraform configuration for the dev environment

module "auth_backend" {
  source = "../../modules/auth_backend"

  type              = "userpass"
  description       = "Development environment auth backend"
  path              = "auth-dev"
  default_lease_ttl = "3600s"
  max_lease_ttl     = "7200s"
}