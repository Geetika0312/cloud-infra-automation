resource "azurerm_virtual_network" "this" {
  name                = "vnet-${var.name_prefix}"
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet" "aks" {
  name                 = "snet-${var.name_prefix}-aks"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.aks_subnet_prefix
}

# AKS's own cloud-controller-manager adds/removes rules on this NSG
# automatically whenever a Kubernetes Service of type LoadBalancer is
# created or deleted - we don't hardcode inbound app ports here.
resource "azurerm_network_security_group" "aks" {
  name                = "nsg-${var.name_prefix}-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "aks" {
  subnet_id                 = azurerm_subnet.aks.id
  network_security_group_id = azurerm_network_security_group.aks.id
}
