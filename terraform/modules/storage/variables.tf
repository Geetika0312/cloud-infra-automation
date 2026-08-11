variable "name" {
  description = "Storage account name - must be globally unique, lowercase alphanumeric only, 3-24 chars"
  type        = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "container_names" {
  description = "Blob containers to create for application data"
  type        = list(string)
  default     = ["app-data"]
}

variable "tags" {
  type    = map(string)
  default = {}
}
