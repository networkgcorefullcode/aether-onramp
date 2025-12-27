# Variables for the dev environment

######################################
# Kubernetes Auth Backend Variables
######################################
variable "k8s_token_reviewer_jwt" {
  description = "JWT token for the Kubernetes service account used for token review"
  type        = string
  sensitive   = true
  default     = null
}

variable "k8s_issuer" {
  description = "The expected issuer of the Kubernetes service account tokens"
  type        = string
  default     = "https://kubernetes.default.svc.cluster.local"
}

variable "k8s_api_server_url" {
  description = "The URL of the Kubernetes API server"
  type        = string
  default     = "https://localhost:6443"
}