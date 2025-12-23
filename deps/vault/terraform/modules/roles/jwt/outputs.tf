# JWT Auth Role Outputs
output "jwt_role_name" {
  description = "The name of the JWT auth role."
  value       = vault_jwt_auth_backend_role.jwt_role.role_name
}

output "jwt_backend" {
  description = "The backend of the JWT auth role."
  value       = vault_jwt_auth_backend_role.jwt_role.backend
}
