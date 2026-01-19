terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}

  # Explicitly set credentials for OIDC authentication
  client_id       = var.azure_client_id
  tenant_id       = var.azure_tenant_id
  subscription_id = var.azure_subscription_id
  
  # Use OIDC token from GitHub Actions
  oidc_token = var.azure_oidc_token
  use_oidc   = true

  skip_provider_registration = false
}