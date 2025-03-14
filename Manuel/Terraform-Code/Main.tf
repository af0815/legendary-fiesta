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


# Define the network interface

resource "azurerm_network_interface" "Manuel-nic" {
  name                = "Manuel-nic"
  location            = azurerm_resource_group.Manuel.location
  resource_group_name = azurerm_resource_group.Manuel.name

  ip_configuration {
    name                          = "Manuel-ipcfg"
    subnet_id                     = azurerm_subnet.Manuel.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Define the virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "Manuel-vm"
  location            = azurerm_resource_group.Manuel.location
  resource_group_name = azurerm_resource_group.Manuel.name
  network_interface_ids = [
    azurerm_network_interface.Manuel-nic.id,
  ]
  size               = "Standard_DS1_v2"
  admin_username     = "Manuel"
  admin_password     = "34FDA$#214f"  # For demonstration purposes only. Use secure methods for production.
  disable_password_authentication = "false"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}