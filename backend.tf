<<<<<<< HEAD
terraform {
  backend "azurerm" {
    resource_group_name = "tfstate-rg"
    storage_account_name = "tfstatebackupstacc"
    container_name = "tfstate"
    key = "rg.terraform.tfstate"
  }
=======
terraform {
  backend "azurerm" {
    resource_group_name = "tfstate-rg"
    storage_account_name = "tfstatebackupstacc"
    container_name = "tfstate"
    key = "rg.terraform.tfstate"
  }
>>>>>>> 34f25756f2f238a8f1e68cd7e93f3667b12da50f
}