data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurecaf_name" "caf_name" {
  name          = lower(var.name)
  resource_type = "azurerm_storage_account"
  prefixes      = ["sanmbrs"]
  suffixes      = [lower("${var.environment}")]
  clean_input   = true
  use_slug      = false
}

resource "azurerm_storage_account" "storage_account" {
  name                      = azurecaf_name.caf_name.result
  resource_group_name       = data.azurerm_resource_group.rg.name
  location                  = data.azurerm_resource_group.rg.location
  account_kind              = var.account_kind
  account_tier              = var.account_tier
  account_replication_type  = var.replication_type
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"

  lifecycle {
    ignore_changes = [tags]
  }
}
