terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.59.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "410df174-57d7-4fa1-bc3d-11f62f6e3845"
}