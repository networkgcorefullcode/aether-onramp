# Variables
variable "path" {
  description = "The path of the generic endpoint."
  type        = string
}

variable "data_json" {
  description = "The JSON data to write to the endpoint."
  type        = any
  ephemeral = false
  sensitive = var.sensitive_data
  default     = {}
}

variable "sensitive_data" {
  description = "Indicates if the data_json contains sensitive information."
  type        = bool
  default     = false
}