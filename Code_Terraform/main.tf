resource "azurerm_resource_group" "Alex" {
  name     = "Alex-resources"
  location = "West Europe"
 
  tags = {
    Owner = "alex.frischmann@redbull.com"
  }
}

resource "azurerm_resource_group" "Manuel" {
  name     = "Manuel-resources"
  location = "West Europe"
 
  tags = {
    Owner = "manuel.trommer@redbull.com"
  }
}


module "vnet-Manuel" {
  source                = "./modules/vnet"
  vnet_name             = "manuel-vnet"
  address_space         = ["10.0.0.0/16"]
  location              = "East US"
  resource_group_name   = "manuel-rg"
  subnet_name           = "manuel-subnet"
  subnet_prefixes       = ["10.0.1.0/24"]
}

module "vnet-Alex" {
  source                = "./modules/vnet"
  vnet_name             = "alex-vnet"
  address_space         = ["10.1.0.0/16"]
  location              = "East US"
  resource_group_name   = "alex-rg"
  subnet_name           = "alex-subnet"
  subnet_prefixes       = ["10.1.1.0/24"]
}

module "vm-Manuel" {
  source                = "./modules/vm"
  vm_name               = "manuel-vm"
  nic_name              = "manuel-nic"
  location              = azurerm_resource_group.Manuel.location
  resource_group_name   = azurerm_resource_group.Manuel.name
  subnet_id             = module.vnet-Manuel.subnet_id
  vm_size               = "Standard_DS1_v2"
  os_disk_name          = "manuel-os-disk"
  image_publisher       = "Canonical"
  image_offer           = "UbuntuServer"
  image_sku             = "18.04-LTS"
  image_version         = "latest"
  computer_name         = "manuel-computer"
  admin_username        = "manuel-admin"
  admin_password        = "P@ssw0rd123!"
  disable_password_authentication = false
  public_ip_sku         = "Standard"
  public_ip_allocation  = "Static"
  public_ip_name        = "manuel-public-ip"
}

module "vm-Alex" {
  source                = "./modules/vm"
  vm_name               = "alex-vm"
  nic_name              = "alex-nic"
  location              = azurerm_resource_group.Alex.location
  resource_group_name   = azurerm_resource_group.Alex.name
  subnet_id             = module.vnet-Alex.subnet_id 
  vm_size               = "Standard_DS1_v2"
  os_disk_name          = "alex-os-disk"
  image_publisher       = "Canonical"
  image_offer           = "UbuntuServer"
  image_sku             = "18.04-LTS"
  image_version         = "latest"
  computer_name         = "alex-computer"
  admin_username        = "alex-admin"
  admin_password        = "P@ssw0rd123!!"
  disable_password_authentication = false
  public_ip_sku         = "Standard"
  public_ip_allocation  = "Static"
  public_ip_name        = "alex-public-ip"
}
