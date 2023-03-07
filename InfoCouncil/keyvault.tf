resource "azurerm_private_dns_zone" "kv_dns" {
  name                              = var.kv_dns_name
  resource_group_name               = var.rg_name
  tags                              = var.tags
}

resource "azurerm_private_dns_a_record" "kv_dns_a_record" {
  name                              = var.kv_dns_a_record_name
  zone_name                         = azurerm_private_dns_zone.kv_dns.name
  resource_group_name               = var.rg_name
  ttl                               = 300
  records                           = [azurerm_private_endpoint.kv_pe.private_service_connection.0.private_ip_address]
  depends_on                        = [azurerm_private_endpoint.kv_pe]
  tags                              = var.tags
}

resource "azurerm_private_endpoint" "kv_pe" {
  name                              = var.kv_privateendpoint_name
  location                          = var.location
  resource_group_name               = var.rg_name
  subnet_id                         = var.subnet4_id
  tags                              = var.tags

  private_service_connection {
    name                            = var.kv_psc_name
    private_connection_resource_id  = azurerm_key_vault.keyvault.id
    # group_ids                       = [azurerm_resource_group.rg_name.id]
    is_manual_connection            = false
    subresource_names               = ["vault"]
  }

  private_dns_zone_group {
    name                            = var.kv_dzg_name
    private_dns_zone_ids            = [azurerm_private_dns_zone.kv_dns.id]
  }
}

resource "azurerm_key_vault" "keyvault" {
  name                              = var.kv_name
  location                          = var.location
  resource_group_name               = var.rg_name
  tenant_id                         = var.tenant_id
  sku_name                          = var.kv_sku_name
  enabled_for_disk_encryption       = true
  enable_rbac_authorization         = true
  
  network_acls {
    bypass                          = "AzureServices"
    default_action                  = "Deny"
    ip_rules                        = ["121.200.6.246"]
    virtual_network_subnet_ids      = [var.subnet1_id, var.subnet2_id, var.subnet3_id, var.subnet4_id]
  }

  tags                              = var.tags
}