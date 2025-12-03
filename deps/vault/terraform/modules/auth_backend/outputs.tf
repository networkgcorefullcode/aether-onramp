# Outputs for Vault auth_backend module

output "path" {
  description = "The path where the auth backend is mounted."
  value       = vault_auth_backend.this.path
}

output "type" {
  description = "The type of the auth backend."
  value       = vault_auth_backend.this.type
}

output "accessor" {
  description = "The accessor for the auth backend."
  value       = vault_auth_backend.this.accessor
}

output "description" {
  description = "The description of the auth backend."
  value       = vault_auth_backend.this.description
}
