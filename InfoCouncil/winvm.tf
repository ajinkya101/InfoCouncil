resource "azurerm_network_interface" "nic" {
  name                              = lower("nic-${var.virtual_machine_name}")
  resource_group_name               = var.rg_name
  location                          = var.location

  ip_configuration {
    name                          = lower("ipconfig-${var.virtual_machine_name}")
    subnet_id                     = var.subnet1_id
    private_ip_address_allocation = var.private_ip_address_allocation_type
    private_ip_address            = var.private_ip_address_allocation_type == "Static" ? element(concat(var.private_ip_address, [""]), 0) : null
  }
}

resource "random_password" "passwd" {
  length      = var.random_password_length
  min_upper   = 4
  min_lower   = 2
  min_numeric = 4
  special     = false

  keepers = {
    admin_password = var.virtual_machine_name
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                              = var.virtual_machine_name
  resource_group_name               = var.rg_name
  location                          = var.location
  size                              = var.virtual_machine_size
  admin_username                    = var.admin_username
  admin_password                    = var.admin_password == null ? element(concat(random_password.passwd.*.result, [""]), 0) : var.admin_password
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    storage_account_type      = var.os_disk_storage_account_type
    caching                   = var.os_disk_caching
  }

  source_image_reference {
    publisher = var.os_publisher 
    offer     = var.os_offer 
    sku       = var.os_sku 
    version   = var.os_version 
  }
}