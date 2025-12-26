terraform {
  # Backend is commented out; using HCP Terraform cloud instead (configured in main.tf)
   backend "azurerm" {
     resource_group_name = "tfstate-rg"
     storage_account_name = "tfstatebackupstacc2612"
     container_name = "tfstate"
     key = "rg.terraform.tfstate"
   }
}