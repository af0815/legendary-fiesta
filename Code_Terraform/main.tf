
#-----Alex-----#
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
 
 
# Define the network interface
resource "azurerm_network_interface" "Alex-nic" {
  name                = "Alex-nic"
  location            = azurerm_resource_group.Alex.location
  resource_group_name = azurerm_resource_group.Alex.name
 
  ip_configuration {
    name                          = "Alex-ipcfg"
    subnet_id                     = azurerm_subnet.Alex.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_terraform_public_ip_Alex.id
  }
}
 
# Define the virtual machine
resource "azurerm_linux_virtual_machine" "vm_Alex" {
  name                = "Alex-vm"
  location            = azurerm_resource_group.Alex.location
  resource_group_name = azurerm_resource_group.Alex.name
  network_interface_ids = [
    azurerm_network_interface.Alex-nic.id,
  ]
  size               = "Standard_B1s"
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
 
# Create public IPs
resource "azurerm_public_ip" "my_terraform_public_ip_Alex" {
  name                = "myPublicIP"
  location            = azurerm_resource_group.Alex.location
  resource_group_name = azurerm_resource_group.Alex.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}


#-----Manuel-----#
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
    public_ip_address_id          = azurerm_public_ip.my_terraform_public_ip_Manuel.id
  }
}



# Define the virtual machine
resource "azurerm_linux_virtual_machine" "vm_Manuel" {
  name                = "Manuel-vm"
  location            = azurerm_resource_group.Manuel.location
  resource_group_name = azurerm_resource_group.Manuel.name
  network_interface_ids = [
    azurerm_network_interface.Manuel-nic.id,
  ]
  size               = "Standard_B1s"
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

# Create public IPs
resource "azurerm_public_ip" "my_terraform_public_ip_Manuel" {
  name                = "myPublicIP"
  location            = azurerm_resource_group.Manuel.location
  resource_group_name = azurerm_resource_group.Manuel.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}
 
 
 
 