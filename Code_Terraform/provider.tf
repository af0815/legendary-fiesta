provider "azurerm" {
    resource_provider_registrations = "none"
    features {}
}

terraform {
  cloud {
    organization = "marchaton"

    workspaces {
      name = "Legendary-Fiesta"
    }
  }
}

#test
