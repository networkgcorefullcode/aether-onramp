# Outputs for Vault transit secret backend key module

output "name" {
  description = "The name of the encryption key."
  value       = vault_transit_secret_backend_key.key.name
}

output "backend" {
  description = "The path to the transit secret backend."
  value       = vault_transit_secret_backend_key.key.backend
}

output "type" {
  description = "The type of the encryption key."
  value       = vault_transit_secret_backend_key.key.type
}

output "latest_version" {
  description = "The latest version of the key."
  value       = vault_transit_secret_backend_key.key.latest_version
}

output "min_available_version" {
  description = "The minimum available version of the key."
  value       = vault_transit_secret_backend_key.key.min_available_version
}

output "keys" {
  description = "A list of all key versions."
  value       = vault_transit_secret_backend_key.key.keys
}

output "supports_encryption" {
  description = "Whether the key supports encryption operations."
  value       = vault_transit_secret_backend_key.key.supports_encryption
}

output "supports_decryption" {
  description = "Whether the key supports decryption operations."
  value       = vault_transit_secret_backend_key.key.supports_decryption
}

output "supports_derivation" {
  description = "Whether the key supports derivation."
  value       = vault_transit_secret_backend_key.key.supports_derivation
}

output "supports_signing" {
  description = "Whether the key supports signing operations."
  value       = vault_transit_secret_backend_key.key.supports_signing
}
