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
  # Explicitly use environment variables:
  # - ARM_CLIENT_ID
  # - ARM_CLIENT_SECRET
  # - ARM_SUBSCRIPTION_ID
  # - ARM_TENANT_ID
  
  # skip_provider_registration is recommended to avoid permission issues
  skip_provider_registration = false
}