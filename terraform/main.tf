# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used

 
# Create a resource group
resource "azurerm_resource_group" "Alex" {
  name     = "Alex-resources"
  location = "West Europe"
}