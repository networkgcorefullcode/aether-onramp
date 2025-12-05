# Variables for roles module
# AppRole variables
variable "approle_backend" {
  description = "The backend for AppRole authentication."
  type        = string
  default     = "approle"
}

variable "approle_role_name" {
  description = "The name of the AppRole role."
  type        = string
  default     = "miapp"
}

variable "approle_token_policies" {
  description = "List of policies to attach to AppRole tokens."
  type        = list(string)
}

variable "approle_token_ttl" {
  description = "The TTL for AppRole tokens in seconds."
  type        = number
  default     = 3600
}

variable "approle_token_max_ttl" {
  description = "The maximum TTL for AppRole tokens in seconds."
  type        = number
  default     = 7200
}

variable "approle_secret_id_metadata" {
  description = "Metadata to attach to AppRole secret IDs."
  type        = map(string)
  default     = {}
}