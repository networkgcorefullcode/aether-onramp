# Kubernetes Auth Backend
module "k8s_auth_dev" {
  source = "../../modules/vault_k8s"

  # Auth Backend Configuration
  auth_type         = "kubernetes"
  auth_description  = "Kubernetes authentication backend for Dev environment"
  auth_path         = "kubernetes"
  default_lease_ttl = "3600s"  # 1 hour
  max_lease_ttl     = "86400s" # 24 hours

  # Kubernetes Configuration
  kubernetes_host        = "https://192.168.12.16:6443"
  kubernetes_ca_cert     = file("/etc/kubernetes/pki/ca.crt")
  token_reviewer_jwt     = var.k8s_token_reviewer_jwt
  issuer                 = "https://192.168.12.16:6443"
  disable_iss_validation = false
}

# Kubernetes Role for UDM
module "k8s_role_udm" {
  source = "../../modules/roles/kubernetes"

  k8s_backend                          = module.k8s_auth_dev.auth_backend_path
  k8s_role_name                        = "udm"
  k8s_bound_service_account_names      = ["udm"]
  k8s_bound_service_account_namespaces = ["aether-5gc"]
  k8s_token_policies                   = [module.policies["dev_policy"].name]
  k8s_token_ttl                        = 3600  # 1 hour
}

# Kubernetes Role for WebConsole
module "k8s_role_webconsole" {
  source = "../../modules/roles/kubernetes"

  k8s_backend                          = module.k8s_auth_dev.auth_backend_path
  k8s_role_name                        = "webui"
  k8s_bound_service_account_names      = ["webui"]
  k8s_bound_service_account_namespaces = ["aether-5gc"]
  k8s_token_policies                   = [module.policies["dev_policy"].name]
  k8s_token_ttl                        = 3600  # 1 hour
}
