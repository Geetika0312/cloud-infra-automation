variable "name" {
  description = "ACR name - must be globally unique, alphanumeric only, 5-50 chars"
  type        = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "sku" {
  description = "Basic is the cheapest tier and is enough for a small project"
  type        = string
  default     = "Basic"
}

variable "tags" {
  type    = map(string)
  default = {}
}
