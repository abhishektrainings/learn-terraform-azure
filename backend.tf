terraform {
  backend "azurerm" {
    resource_group_name = "tfstate-rg"
    storage_account_name = "tfstatebackupstacc"
    container_name = "tfstate"
    key = "rg.terraform.tfstate"
  }
}