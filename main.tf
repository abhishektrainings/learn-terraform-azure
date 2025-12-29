# Resource Group and Virtual Network are managed by the vnet module
module "vnet" {
  source = "./modules/vnet"

  vnet_name           = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
}