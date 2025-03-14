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

# Create Subnet
resource "azurerm_subnet" "Alex" {
  name                 = "Alex-subnet"
  resource_group_name  = azurerm_resource_group.Alex.name
  virtual_network_name = azurerm_virtual_network.Alex.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "Alex-nic" {
  name                = "Alex-nic"
  location            = azurerm_resource_group.Alex.location
  resource_group_name = azurerm_resource_group.Alex.name

  ip_configuration {
    name                          = "Alex-ipcfg"
    subnet_id                     = azurerm_subnet.Alex.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Define the virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "Alex-vm"
  location            = azurerm_resource_group.Alex.location
  resource_group_name = azurerm_resource_group.Alex.name
  network_interface_ids = [
    azurerm_network_interface.Alex-nic.id,
  ]
  size               = "Standard_DS1_v2"
  admin_username     = "Alex"
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