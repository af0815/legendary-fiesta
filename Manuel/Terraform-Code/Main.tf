# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "Manuel" {
  name     = "Manuel-resources"
  location = "West Europe"

  tags = {
    Owner = "manuel.trommer@redbull.com"
  }
}


# Create a virtual network within the resource group
resource "azurerm_virtual_network" "Manuel" {
  name                = "Manuel-network"
  resource_group_name = azurerm_resource_group.Manuel.name
  location            = azurerm_resource_group.Manuel.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "Manuel" {
  name                 = "Manuel-subnet"
  resource_group_name  = azurerm_resource_group.Manuel.name
  virtual_network_name = azurerm_virtual_network.Manuel.name
  address_prefixes     = ["10.0.1.0/24"]
}