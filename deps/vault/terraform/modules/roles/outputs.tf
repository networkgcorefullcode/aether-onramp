# Outputs for roles module

# AppRole outputs
output "approle_role_name" {
  description = "The name of the AppRole role."
  value       = vault_approle_auth_backend_role.app_role.role_name
}

output "approle_role_id" {
  description = "The Role ID for AppRole authentication."
  value       = vault_approle_auth_backend_role_id.app_role_id.role_id
  sensitive   = true
}

output "approle_secret_id" {
  description = "The Secret ID for AppRole authentication."
  value       = vault_approle_auth_backend_secret_id.app_secret_id.secret_id
  sensitive   = true
}

output "approle_backend" {
  description = "The backend path for AppRole."
  value       = vault_approle_auth_backend_role.app_role.backend
}

# Kubernetes Auth outputs
output "k8s_role_name" {
  description = "The name of the Kubernetes auth role."
  value       = vault_kubernetes_auth_backend_role.k8s_role.role_name
}

output "k8s_backend" {
  description = "The backend path for Kubernetes auth."
  value       = vault_kubernetes_auth_backend_role.k8s_role.backend
}

# JWT Auth outputs
output "jwt_role_name" {
  description = "The name of the JWT auth role."
  value       = vault_jwt_auth_backend_role.jwt_role.role_name
}

output "jwt_backend" {
  description = "The backend path for JWT auth."
  value       = vault_jwt_auth_backend_role.jwt_role.backend
}

# PKI Role outputs
output "pki_role_name" {
  description = "The name of the PKI role."
  value       = vault_pki_secret_backend_role.pki_role.name
}

output "pki_backend" {
  description = "The backend path for PKI."
  value       = vault_pki_secret_backend_role.pki_role.backend
}
