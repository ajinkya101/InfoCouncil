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