output "id" {
  value = azurerm_kubernetes_cluster.this.id
}

output "name" {
  value = azurerm_kubernetes_cluster.this.name
}

output "kube_config_raw" {
  value     = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive = true
}

output "node_resource_group" {
  description = "The auto-created resource group holding the cluster's VMs, disks, LBs, public IPs"
  value       = azurerm_kubernetes_cluster.this.node_resource_group
}
