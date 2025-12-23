# Certificate Auth Role Outputs
output "cert_role_name" {
  description = "The name of the Certificate auth role."
  value       = vault_cert_auth_backend_role.cert_role.name
}

output "cert_backend" {
  description = "The backend of the Certificate auth role."
  value       = vault_cert_auth_backend_role.cert_role.backend
}
