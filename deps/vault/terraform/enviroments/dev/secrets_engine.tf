module "rest_secret_engine_dev" {
    source                    = "../../modules/vault_mount"
    path                      = "dev"
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
    path        = "dev"
    type        = "transit"
    description = "This is an example transit secret engine mount"

    default_lease_ttl_seconds = 3600
    max_lease_ttl_seconds     = 7200
    options = {
        convergent_encryption = false
    }
}