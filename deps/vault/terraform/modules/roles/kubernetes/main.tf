resource "vault_kubernetes_auth_backend_role" "k8s_role" {
  backend                          = var.k8s_backend
  role_name                        = var.k8s_role_name
  bound_service_account_names      = var.k8s_bound_service_account_names
  bound_service_account_namespaces = var.k8s_bound_service_account_namespaces
  token_policies                   = var.k8s_token_policies
  token_ttl                        = var.k8s_token_ttl
}
