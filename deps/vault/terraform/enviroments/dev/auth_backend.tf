# Main Terraform configuration for the dev environment

module "auth_backend" {
  source = "../../modules/auth_backend"

  type              = var.auth_type
  description       = var.auth_description
  path              = var.auth_path
  default_lease_ttl = var.auth_default_lease_ttl
  max_lease_ttl     = var.auth_max_lease_ttl
}