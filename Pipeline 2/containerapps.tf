data "azurerm_container_app_environment" "cae" {
  name                = var.cae_name
  resource_group_name = var.rg_name
}

data "azurerm_container_registry" "acr" {
  name                = var.container_registry_name
  resource_group_name = var.rg_name
}

data "azurerm_key_vault" "kv" {
  name                = var.kv_name
  resource_group_name = var.rg_name
}

resource "azurerm_user_assigned_identity" "containerapp" {
  location            = var.location
  name                = var.user_identity
  resource_group_name = var.rg_name
}

resource "azurerm_role_assignment" "containerapp" {
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "acrpull"
  principal_id         = azurerm_user_assigned_identity.containerapp.principal_id
  depends_on = [
    azurerm_user_assigned_identity.containerapp
  ]
}

resource "azurerm_role_assignment" "containerappkv" {
  scope                = data.azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = azurerm_user_assigned_identity.containerapp.principal_id
  depends_on = [
    azurerm_user_assigned_identity.containerapp
  ]
}

resource "azurerm_container_app" "cnapp" {
  name                         = var.container_app_name
  container_app_environment_id = data.azurerm_container_app_environment.cae.id
  resource_group_name          = var.rg_name
  tags                         = var.tags
  revision_mode                = "Multiple"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.containerapp.id]
  }

  registry {
    server   = data.azurerm_container_registry.acr.login_server
    identity = azurerm_user_assigned_identity.containerapp.id
  }

  ingress {
    target_port = 80
    transport   = "auto"

    traffic_weight {
      percentage = 100
    }
  }

  template {
    container {
      name   = "examplecontainerapp"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
}