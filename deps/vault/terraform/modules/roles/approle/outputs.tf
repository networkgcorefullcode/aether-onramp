# Outputs for Vault roles module

output "approle_role_name" {
  description = "The name of the AppRole."
  value       = length(vault_approle_auth_backend_role.app_role) > 0 ? vault_approle_auth_backend_role.app_role[0].role_name : null
}

output "approle_role_id" {
  description = "The role ID of the AppRole."
  value       = length(vault_approle_auth_backend_role.app_role) > 0 ? vault_approle_auth_backend_role.app_role[0].role_id : null
  sensitive   = true
}

output "approle_backend" {
  description = "The backend of the AppRole."
  value       = length(vault_approle_auth_backend_role.app_role) > 0 ? vault_approle_auth_backend_role.app_role[0].backend : null
}