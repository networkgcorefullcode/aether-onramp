# Outputs for Vault roles module

output "approle_role_name" {
  description = "The name of the AppRole."
  value       = vault_approle_auth_backend_role.app_role
}

output "approle_role_id" {
  description = "The role ID of the AppRole."
  value       = vault_approle_auth_backend_role.app_role
  sensitive   = true
}

output "approle_backend" {
  description = "The backend of the AppRole."
  value       = vault_approle_auth_backend_role.app_role
}