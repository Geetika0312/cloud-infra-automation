variable "location" {
  type    = string
  default = "canadacentral"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "project" {
  type    = string
  default = "cloudinfra"
}

variable "node_count" {
  description = "AKS node count - keep at 1 for dev to minimize cost"
  type        = number
  default     = 1
}

variable "node_vm_size" {
  type    = string
  default = "Standard_B2s"
}
