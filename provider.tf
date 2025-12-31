variable "client_secret" {
}

# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  client_id       = "af0caf81-3f81-4c3b-ba44-9a64afcee240"
  client_secret   = var.client_secret
  tenant_id       = "69e2d3ca-622c-43e1-86ee-fd6a642240ac"
  subscription_id = "992fe4cd-e4d9-4eab-9b5f-a6eb24758946"
}