locals {
  name_prefix = "${var.project}-${var.environment}"
  tags = {
    project     = var.project
    environment = var.environment
    managed_by  = "terraform"
  }
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${local.name_prefix}"
  location = var.location
  tags     = local.tags
}

# ACR and storage account names must be globally unique across Azure, so
# every deploy gets its own random suffix.
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

module "networking" {
  source = "../../modules/networking"

  name_prefix         = local.name_prefix
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  tags                = local.tags
}

module "acr" {
  source = "../../modules/acr"

  name                = "acr${replace(local.name_prefix, "-", "")}${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  tags                = local.tags
}

module "aks" {
  source = "../../modules/aks"

  name                = "aks-${local.name_prefix}"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  dns_prefix          = local.name_prefix
  subnet_id           = module.networking.aks_subnet_id
  acr_id              = module.acr.id
  node_count          = var.node_count
  node_vm_size        = var.node_vm_size
  tags                = local.tags
}

module "storage" {
  source = "../../modules/storage"

  name                = "st${replace(local.name_prefix, "-", "")}${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  tags                = local.tags
}
