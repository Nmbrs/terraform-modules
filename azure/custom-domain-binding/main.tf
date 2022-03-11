data "azurerm_dns_zone" "binding" {
  name                = var.dns_zone
  resource_group_name = "rg-dnszones"
}

resource "azurerm_dns_cname_record" "binding" {
  for_each            = var.apps
  name                = each.value["name"]
  zone_name           = data.azurerm_dns_zone.binding.name
  resource_group_name = data.azurerm_dns_zone.binding.resource_group_name
  ttl                 = 300
  record              = "${each.value["record"]}.azurewebsites.net"
}

data "azurerm_app_service" "binding" {
  for_each            = var.app_name
  name                = each.value
  resource_group_name = var.resource_group
}

resource "azurerm_dns_txt_record" "binding" {
  for_each            = var.apps
  name                = "asuid.${each.value["name"]}"
  zone_name           = data.azurerm_dns_zone.binding.name
  resource_group_name = data.azurerm_dns_zone.binding.resource_group_name
  ttl                 = 300
  record {
    value = data.azurerm_app_service.binding[each.key].custom_domain_verification_id
  }
}

resource "azurerm_app_service_custom_hostname_binding" "binding" {
  for_each            = var.apps
  hostname            = each.value["custom_domain"]
  app_service_name    = data.azurerm_app_service.binding[each.key].name
  resource_group_name = data.azurerm_app_service.binding[each.key].resource_group_name
  depends_on          = [azurerm_dns_txt_record.binding]

  lifecycle {
    ignore_changes = [ssl_state, thumbprint]
  }
}

data "azurerm_key_vault" "binding" {
  name                = var.keyvault_name
  resource_group_name = "RG-InfraAutomation"
}

data "azurerm_key_vault_certificate" "binding" {
  name         = var.certificate_name
  key_vault_id = data.azurerm_key_vault.binding.id
}

resource "azurerm_app_service_certificate" "binding" {
  for_each            = var.apps
  name                = data.azurerm_key_vault_certificate.binding.name
  resource_group_name = data.azurerm_app_service.binding[each.key].resource_group_name
  location            = var.location
  key_vault_secret_id = data.azurerm_key_vault_certificate.binding.secret_id
}

resource "azurerm_app_service_certificate_binding" "binding" {
  for_each            = var.apps
  hostname_binding_id = azurerm_app_service_custom_hostname_binding.binding[each.key].id
  certificate_id      = azurerm_app_service_certificate.binding[each.key].id
  ssl_state           = "SniEnabled"
}
