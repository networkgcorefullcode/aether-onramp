# PKI Role Outputs
output "pki_role_name" {
  description = "The name of the PKI role."
  value       = vault_pki_secret_backend_role.pki_role.name
}

output "pki_backend" {
  description = "The backend of the PKI role."
  value       = vault_pki_secret_backend_role.pki_role.backend
}
