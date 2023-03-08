resource "azurerm_public_ip" "pip" {
  name                              = var.bastion_pip_name
  resource_group_name               = var.rg_name
  location                          = var.location
  allocation_method                 = var.bastion_allocation_method
  sku                               = var.bastion_sku
}

resource "azurerm_bastion_host" "example" {
  name                              = var.bastion_name
  resource_group_name               = var.rg_name
  location                          = var.location

  ip_configuration {
    name                 = "config"
    subnet_id            = var.bastion_subnet_id
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}