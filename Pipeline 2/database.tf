data "azurerm_mssql_server" "sqlserver" {
  name                = var.ss_name
  resource_group_name = var.rg_name
}

data "azurerm_mssql_elasticpool" "msppol" {
  name                = var.ss_ep_name
  resource_group_name = var.rg_name
  server_name         = data.azurerm_mssql_server.sqlserver.name
}

resource "azurerm_mssql_database" "db" {
  name            = var.db_name
  server_id       = data.azurerm_mssql_server.sqlserver.id
  collation       = "SQL_Latin1_General_CP1_CI_AS"
  license_type    = "LicenseIncluded"
  sku_name        = "ElasticPool"
  elastic_pool_id = data.azurerm_mssql_elasticpool.msppol.id

  tags = var.tags
}

resource "azurerm_key_vault_secret" "kvsecsql" {
  name         = "secret-${var.db_name}"
  value        = "Server=tcp:${data.azurerm_mssql_server.sqlserver.fully_qualified_domain_name};Database=${azurerm_mssql_database.db.name};TrustServerCertificate=True"  
  key_vault_id = data.azurerm_key_vault.kv.id
}