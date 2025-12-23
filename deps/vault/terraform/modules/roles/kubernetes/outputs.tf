# Kubernetes Auth Role Outputs
output "k8s_role_name" {
  description = "The name of the Kubernetes auth role."
  value       = vault_kubernetes_auth_backend_role.k8s_role.role_name
}

output "k8s_backend" {
  description = "The backend of the Kubernetes auth role."
  value       = vault_kubernetes_auth_backend_role.k8s_role.backend
}
