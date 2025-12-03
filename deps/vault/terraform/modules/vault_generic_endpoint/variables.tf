# Variables
variable "path" {
  description = "The path of the generic endpoint."
  type        = string
}

variable "data_json" {
  description = "The JSON data to write to the endpoint."
  type        = any
  default     = {}
  sensitive = true
}

variable "ignore_absent_fields" {
  default = false
  type = bool
  description = "Whether to ignore absent fields when writing to the endpoint."
}