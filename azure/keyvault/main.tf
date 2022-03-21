data "azurerm_client_config" "current" {}

# Create the Azure Key Vault
resource "azurerm_key_vault" "key_vault" {
  name                       = var.name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = true

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }

  tags = merge(var.tags, local.auto_tags)
}

# Create a Default Azure Key Vault access policy with Admin permissions
# This policy must be kept for a proper run of the "destroy" process
resource "azurerm_key_vault_access_policy" "default_policy" {
  key_vault_id = azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  lifecycle {
    create_before_destroy = true
  }

  secret_permissions      = local.secrets_full_permissions
  certificate_permissions = local.certificates_full_permissions
}

data "azuread_group" "ad_group" {
  for_each         = toset(concat(var.readers, var.writers))
  display_name     = each.key
  security_enabled = true
}

resource "azurerm_key_vault_access_policy" "readers_policy" {
  for_each                = toset(var.readers)
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azuread_group.ad_group[each.key].object_id
  secret_permissions      = local.secrets_read_permissions
  certificate_permissions = local.certificates_read_permissions
}

resource "azurerm_key_vault_access_policy" "writers_policy" {
  for_each                = toset(var.writers)
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azuread_group.ad_group[each.key].object_id
  secret_permissions      = local.secrets_write_permissions
  certificate_permissions = local.certificates_write_permissions
}
