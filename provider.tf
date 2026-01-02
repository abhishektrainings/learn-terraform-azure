terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
}

provider "azurerm" {
  features {}

  # Service Principal authentication (for CI/CD pipelines)
  # Set these environment variables: ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_SUBSCRIPTION_ID, ARM_TENANT_ID
  
  # Alternatively, use Azure CLI authentication
  # Run 'az login' to authenticate as a user
}