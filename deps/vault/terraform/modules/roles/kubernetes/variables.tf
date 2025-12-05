# Kubernetes Auth variables
variable "k8s_backend" {
  description = "The backend for Kubernetes authentication."
  type        = string
  default     = "kubernetes"
}

variable "k8s_role_name" {
  description = "The name of the Kubernetes auth role."
  type        = string
}

variable "k8s_bound_service_account_names" {
  description = "List of service account names that can authenticate."
  type        = list(string)
  default     = ["vault-client"]
}

variable "k8s_bound_service_account_namespaces" {
  description = "List of namespaces that service accounts can authenticate from."
  type        = list(string)
  default     = ["default"]
}

variable "k8s_token_policies" {
  description = "List of policies to attach to Kubernetes auth tokens."
  type        = list(string)
}

variable "k8s_token_ttl" {
  description = "The TTL for Kubernetes auth tokens in seconds."
  type        = number
  default     = 3600
}
