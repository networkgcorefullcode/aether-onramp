module "rest_secret_engine_dev" {
    source                    = "../../modules/vault_mount"
    path                      = "kv-dev"
    type                      = "kv-v2"
    description               = "KV secrets engine for development environment"
    default_lease_ttl_seconds = 3600
    max_lease_ttl_seconds     = 7200
   
    options = {
        version = "2"
        type    = "kv-v2"
    }
}

module "transit_secret_engine_dev" {
    source      = "../../modules/vault_mount"
    path        = "transit-dev"
    type        = "transit"
    description = "Transit dev secret engine"

    default_lease_ttl_seconds = 3600
    max_lease_ttl_seconds     = 7200
    options = {
        convergent_encryption = false
    }
}

module "pki_secret_engine_dev" {
  source      = "../../modules/vault_mount"

  path        = "pki-dev"
  type        = "pki"
  description = "This is an example PKI mount dev"

  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
}