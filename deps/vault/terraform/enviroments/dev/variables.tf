# Variables for the dev environment

######################################
# Auth backend configuration variables
######################################
variable "auth_type" {
  description = "The type of the auth backend (e.g., 'userpass', 'github')."
  type        = string
  default     = "userpass"
}

variable "auth_description" {
  description = "A human-friendly description of the auth backend."
  type        = string
  default     = "Development environment auth backend"
}

variable "auth_path" {
  description = "The path where the auth backend will be mounted."
  type        = string
  default     = "auth/dev"
}

variable "auth_default_lease_ttl" {
  description = "The default lease TTL for tokens issued by this auth backend."
  type        = number
  default     = 3600
}

variable "auth_max_lease_ttl" {
  description = "The maximum lease TTL for tokens issued by this auth backend."
  type        = number
  default     = 7200
}