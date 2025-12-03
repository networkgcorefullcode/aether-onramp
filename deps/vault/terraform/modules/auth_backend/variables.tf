# Variables
variable "type" {
  description = "The type of the auth backend (e.g., 'userpass', 'github')."
  type        = string
}

variable "description" {
  description = "A human-friendly description of the auth backend."
  type        = string
  default     = null
}

variable "path" {
  description = "The path where the auth backend will be mounted."
  type        = string
  default     = null
}

variable "default_lease_ttl" {
  description = "The default lease TTL for tokens issued by this auth backend."
  type        = number
  default     = null
}

variable "max_lease_ttl" {
  description = "The maximum lease TTL for tokens issued by this auth backend."
  type        = number
  default     = null
}