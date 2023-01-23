terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.40"
    }

    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "2.0.0-preview3"
    }
  }

  required_version = ">= 1.3.0, < 2.0.0"
}

provider "azurerm" {
  features {
  }
}
