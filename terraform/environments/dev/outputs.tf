output "resource_group_name" {
  value = azurerm_resource_group.this.name
}

output "aks_cluster_name" {
  value = module.aks.name
}

output "acr_login_server" {
  value = module.acr.login_server
}

output "storage_account_name" {
  value = module.storage.name
}

output "aks_node_resource_group" {
  description = "Where the cluster's actual VMs/disks/LB/public-IP live - useful when checking costs"
  value       = module.aks.node_resource_group
}
