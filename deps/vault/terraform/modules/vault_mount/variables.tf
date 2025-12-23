# Variables for Vault mount module

variable "path" {
  description = "The path where the secrets engine will be mounted."
  type        = string
}

variable "type" {
  description = "The type of the secrets engine (e.g., 'kv', 'pki', 'transit')."
  type        = string
}

variable "description" {
  description = "A human-friendly description of the mount."
  type        = string
  default     = null
}

variable "default_lease_ttl_seconds" {
  description = "The default lease TTL in seconds."
  type        = number
  default     = null
}

variable "max_lease_ttl_seconds" {
  description = "The maximum lease TTL in seconds."
  type        = number
  default     = null
}

variable "options" {
  description = "Mount-specific options (e.g., version for kv engine)."
  type        = map(string)
  default     = {}
}
