# Outputs for Vault mount module

output "path" {
  description = "The path where the secrets engine is mounted."
  value       = vault_mount.this.path
}

output "type" {
  description = "The type of the secrets engine."
  value       = vault_mount.this.type
}

output "description" {
  description = "The description of the mount."
  value       = vault_mount.this.description
}

output "default_lease_ttl_seconds" {
  description = "The default lease TTL in seconds."
  value       = vault_mount.this.default_lease_ttl_seconds
}

output "max_lease_ttl_seconds" {
  description = "The maximum lease TTL in seconds."
  value       = vault_mount.this.max_lease_ttl_seconds
}

output "accessor" {
  description = "The accessor for the mount."
  value       = vault_mount.this.accessor
}
