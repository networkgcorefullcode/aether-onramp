module "transit_keys_dev" {
    source = "../../modules/vault_transit_secret_backend_key"
    
    backend = module.transit_secret_engine_dev.path
    name    = "aes256-gcm-dev"
}