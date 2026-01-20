terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80"
    }
  }
}

provider "azurerm" {
  features {}

  # Use OIDC authentication via environment variables (ARM_* variables)
  # These are set by GitHub Actions and azure/login@v2
  skip_provider_registration = false
}