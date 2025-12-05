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

# Kubernetes Auth outputs
output "k8s_role_name" {
  description = "The name of the Kubernetes auth role."
  value       = length(vault_kubernetes_auth_backend_role.k8s_role) > 0 ? vault_kubernetes_auth_backend_role.k8s_role[0].role_name : null
}

output "k8s_backend" {
  description = "The backend of the Kubernetes auth role."
  value       = length(vault_kubernetes_auth_backend_role.k8s_role) > 0 ? vault_kubernetes_auth_backend_role.k8s_role[0].backend : null
}

# JWT Auth outputs
output "jwt_role_name" {
  description = "The name of the JWT auth role."
  value       = length(vault_jwt_auth_backend_role.jwt_role) > 0 ? vault_jwt_auth_backend_role.jwt_role[0].role_name : null
}

output "jwt_backend" {
  description = "The backend of the JWT auth role."
  value       = length(vault_jwt_auth_backend_role.jwt_role) > 0 ? vault_jwt_auth_backend_role.jwt_role[0].backend : null
}

# PKI Role outputs
output "pki_role_name" {
  description = "The name of the PKI role."
  value       = length(vault_pki_secret_backend_role.pki_role) > 0 ? vault_pki_secret_backend_role.pki_role[0].name : null
}

output "pki_backend" {
  description = "The backend of the PKI role."
  value       = length(vault_pki_secret_backend_role.pki_role) > 0 ? vault_pki_secret_backend_role.pki_role[0].backend : null
}
