variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "subnet_id" {
  description = "Subnet the AKS node pool's VMs will be placed in"
  type        = string
}

variable "acr_id" {
  description = "ACR resource ID to grant this cluster pull access to"
  type        = string
}

variable "kubernetes_version" {
  description = "Leave null to use whatever AKS currently recommends as default"
  type        = string
  default     = null
}

variable "node_count" {
  description = "Fixed node count (autoscaling is off by default to keep cost predictable)"
  type        = number
  default     = 1
}

variable "node_vm_size" {
  description = "Standard_B2s is a cheap burstable VM, good for a learning cluster"
  type        = string
  default     = "Standard_B2s"
}

variable "sku_tier" {
  description = "Free = no charge for the control plane (no uptime SLA). Use Standard for production."
  type        = string
  default     = "Free"
}

variable "tags" {
  type    = map(string)
  default = {}
}
