resource "azurerm_log_analytics_workspace" "analytics_workspace" {
  name                              = var.aw_name
  resource_group_name               = var.rg_name
  location                          = var.location
  tags                              = var.tags
  sku                               = "PerGB2018"
  retention_in_days                 = 30
}

resource "azurerm_container_app_environment" "cae" {
  name                              = var.cae_name
  resource_group_name               = var.rg_name
  location                          = var.location
  tags                              = var.tags

  infrastructure_subnet_id          = var.subnet2_id
  internal_load_balancer_enabled    = true
  log_analytics_workspace_id        = azurerm_log_analytics_workspace.analytics_workspace.id
}

resource "azurerm_container_registry" "acr" {
  name                = var.container_registry_name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = true
}