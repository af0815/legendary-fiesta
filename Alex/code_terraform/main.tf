# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used

 
# Create a resource group
resource "azurerm_resource_group" "Alex" {
  name     = "Alex-resources"
  location = "West Europe"

  tags = {
    Owner = "alex.frischmann@redbull.com"
  }
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "Alex" {
  name                = "Alex-network"
  resource_group_name = azurerm_resource_group.Alex.name
  location            = azurerm_resource_group.Alex.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "Alex" {
  name                 = "Alex-subnet"
  resource_group_name  = azurerm_resource_group.Alex.name
  virtual_network_name = azurerm_virtual_network.Alex.name
  address_prefixes     = ["10.0.1.0/24"]
}