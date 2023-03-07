output "app_fqdn" {
  value = azurerm_container_app.cnapp.latest_revision_fqdn
}