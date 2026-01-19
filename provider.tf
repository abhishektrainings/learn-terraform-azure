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

  # OIDC authentication for GitHub Actions
  use_oidc = true
  
  # These are automatically populated by azure/login@v2 from GitHub Actions secrets
  client_id       = var.azure_client_id
  tenant_id       = var.azure_tenant_id
  subscription_id = var.azure_subscription_id
  
  skip_provider_registration = false
}