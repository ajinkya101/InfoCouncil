provider "azurerm" {
  alias           = "terraformnorules"
  subscription_id = "b867f15c-4e36-4dda-b7a9-53ba28fe2d21"
  tenant_id       = "4b7e7b89-9ba4-473a-a11b-42f5f814c887"
  features {}
}

provider "azurerm" {
  features {}
}

provider "azuread" {}