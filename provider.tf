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

  # OIDC authentication via environment variables
  # ARM_CLIENT_ID, ARM_TENANT_ID, ARM_SUBSCRIPTION_ID, ARM_OIDC_TOKEN, ARM_USE_OIDC
  
  skip_provider_registration = false
}