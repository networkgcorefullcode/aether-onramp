# Outputs for Vault policy module

output "name" {
  description = "The name of the policy."
  value       = vault_policy.this.name
}

output "policy" {
  description = "The policy content."
  value       = vault_policy.this.policy
  sensitive   = true
}