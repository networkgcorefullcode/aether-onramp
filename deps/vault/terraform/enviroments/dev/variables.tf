# Variables for the dev environment

######################################
# Kubernetes Auth Backend Variables
######################################
variable "k8s_token_reviewer_jwt" {
  description = "JWT token for the Kubernetes service account used for token review"
  type        = string
  sensitive   = true
}