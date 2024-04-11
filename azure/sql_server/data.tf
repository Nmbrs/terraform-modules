data "azuread_group" "sql_admin" {
  display_name     = var.sql_admin
  security_enabled = true
}

data "azurerm_subnet" "subnet" {
  for_each             = { for subnet in var.allowed_subnets : subnet.subnet_name => subnet }
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.subnet_resource_group_name
}

data "azurerm_storage_account" "auditing_storage_account" {
  name                = var.storage_account_auditing
  resource_group_name = var.storage_account_resource_group
}