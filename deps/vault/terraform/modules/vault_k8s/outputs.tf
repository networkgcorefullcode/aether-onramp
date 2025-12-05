# Auth Backend Outputs
output "auth_backend_path" {
    description = "Path where the Kubernetes auth backend is mounted"
    value       = module.auth_backend_k8s.path
}

output "auth_backend_accessor" {
    description = "Accessor of the Kubernetes auth backend"
    value       = module.auth_backend_k8s.accessor
}

# Kubernetes Auth Backend Config Outputs
output "kubernetes_host" {
    description = "Kubernetes API host URL"
    value       = vault_kubernetes_auth_backend_config.this.kubernetes_host
}

output "issuer" {
    description = "JWT issuer configured for validation"
    value       = vault_kubernetes_auth_backend_config.this.issuer
}

output "disable_iss_validation" {
    description = "Whether JWT issuer validation is disabled"
    value       = vault_kubernetes_auth_backend_config.this.disable_iss_validation
}
