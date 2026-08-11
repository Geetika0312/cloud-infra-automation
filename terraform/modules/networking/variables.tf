variable "name_prefix" {
  description = "Prefix applied to all networking resource names, e.g. cloudinfra-dev"
  type        = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_address_space" {
  description = "CIDR block for the VNet"
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "aks_subnet_prefix" {
  description = "CIDR block for the subnet AKS nodes run in"
  type        = list(string)
  default     = ["10.10.1.0/24"]
}

variable "tags" {
  type    = map(string)
  default = {}
}
