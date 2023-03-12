resource "azurerm_private_dns_zone" "ss_dns" {
  name                              = var.ss_dns_name
  resource_group_name               = var.rg_name
  tags                              = var.tags
}

resource "azurerm_private_dns_a_record" "ss_dns_a_record" {
  name                              = var.ss_dns_a_record_name
  zone_name                         = azurerm_private_dns_zone.ss_dns.name
  resource_group_name               = var.rg_name
  ttl                               = 300
  records                           = [azurerm_private_endpoint.ss_pe.private_service_connection.0.private_ip_address]
  depends_on                        = [azurerm_private_endpoint.ss_pe]
  tags                              = var.tags
}

resource "azurerm_private_endpoint" "ss_pe" {
  name                              = var.ss_privateendpoint_name
  resource_group_name               = var.rg_name
  location                          = var.location
  subnet_id                         = var.subnet1_id
  tags                              = var.tags

  private_service_connection {
    name                           = var.ss_psc_name
    private_connection_resource_id = azurerm_mssql_server.sqlserver.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                            = var.ss_dzg_name
    private_dns_zone_ids            = [azurerm_private_dns_zone.ss_dns.id]
  }
}

data "azuread_group" "sqladmins" {
  display_name     = "SQL_ACCESS"
  security_enabled = true
}

data "azurerm_client_config" "sqlconfig" {
}

resource "azurerm_mssql_server" "sqlserver" {
  name                              = var.ss_name
  resource_group_name               = var.rg_name
  location                          = var.location
  version                           = "12.0"
  minimum_tls_version               = "1.2"
  tags                              = var.tags

  azuread_administrator {
    azuread_authentication_only     = true
    login_username                  = "AzureAD_Admin"
    object_id                       = data.azuread_group.sqladmins.object_id
    tenant_id                       = data.azurerm_client_config.sqlconfig.tenant_id
  }
}

resource "azurerm_mssql_virtual_network_rule" "networkrule" {
  name                              = "sql-vnet-rule"
  server_id                         = azurerm_mssql_server.sqlserver.id
  subnet_id                         = var.subnet1_id
  depends_on                        = [azurerm_mssql_server.sqlserver]
}

resource "azurerm_mssql_elasticpool" "ss_ep" {
  name                              = var.ss_ep_name
  resource_group_name               = var.rg_name
  location                          = var.location
  tags                              = var.tags
  server_name                       = var.ss_name
  # license_type                      = "LicenseIncluded"
  max_size_gb                       = 4.8828125

  sku {
    name                            = "BasicPool"
    tier                            = "Basic"
    capacity                        = 50
  }

  per_database_settings {
    min_capacity                    = 0
    max_capacity                    = 5
  }
  depends_on = [azurerm_mssql_server.sqlserver]
}

resource "azurerm_key_vault_secret" "kvsqlpass" {
  name         = "sqlpass"
  value        = element(concat(random_password.passwd.*.result, [""]), 0)
  key_vault_id = azurerm_key_vault.keyvault.id
}