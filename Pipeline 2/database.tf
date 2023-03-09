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

data "azurerm_key_vault_secret" "kvs" {
  name         = "sqlpass"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "kvsecsql" {
  name         = "secret-${var.db_name}"
  value        = "Server=tcp:${data.azurerm_mssql_server.sqlserver.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.db.name};Persist Security Info=False;User ID=${data.azurerm_mssql_server.sqlserver.administrator_login};Password=${data.azurerm_key_vault_secret.kvs.value};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  key_vault_id = data.azurerm_key_vault.kv.id
}