## App Service plan
resource "azurerm_service_plan" "service_plan" {
  name                = local.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name

  lifecycle {
    ignore_changes = [tags]
  }
}

## App Service
resource "azurerm_windows_web_app" "web_app" {
  for_each = toset(var.app_service_names)

  name                    = local.app_service_names[index(var.app_service_names, each.key)]
  resource_group_name     = var.resource_group_name
  client_affinity_enabled = var.client_affinity_enabled
  location                = var.location
  service_plan_id         = azurerm_service_plan.service_plan.id
  https_only              = true

  # identity {
  #   type         = data.azurerm_user_assigned_identity.managed_identity != "" ? "SystemAssigned, UserAssigned" : "SystemAssigned"
  #   identity_ids = data.azurerm_user_assigned_identity.managed_identity != "" ? [data.azurerm_user_assigned_identity.managed_identity[0].id] : []
  # }

identity {
    type         = length(var.managed_identity_name) > 1 && length(var.managed_identity_resource_group) > 1 ? "SystemAssigned, UserAssigned" : "SystemAssigned"
    identity_ids = length(var.managed_identity_name) > 1 && length(var.managed_identity_resource_group) > 1 ? [data.azurerm_user_assigned_identity.managed_identity[0].id] : []
}

  app_settings = {
    "AZURE_CLIENT_ID" = length(var.managed_identity_name) > 1 && length(var.managed_identity_resource_group) > 1 ? data.azurerm_user_assigned_identity.managed_identity[0].client_id : null
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = length(var.app_insights_name) > 1 && length(var.app_insights_resource_group) > 1 ? data.azurerm_application_insights.app_insights[0].connection_string : null
    "APPLICATIONINSIGHTSAGENT_EXTENSION_VERSION" = length(var.app_insights_name) > 1 && length(var.app_insights_resource_group) > 1 ? "~2" : null
  }

  site_config {
    always_on                = true
    minimum_tls_version      = "1.2"
    ftps_state               = "FtpsOnly"
    http2_enabled            = true
    managed_pipeline_mode    = "Integrated"
    use_32_bit_worker        = false
    websockets_enabled       = false
    remote_debugging_enabled = false
    load_balancing_mode      = var.load_balancing_mode
    vnet_route_all_enabled   = true

    application_stack {
      current_stack  = var.stack
      dotnet_version = var.dotnet_version
    }
  }

  lifecycle {
    ignore_changes = [tags, virtual_network_subnet_id, identity, app_settings, sticky_settings, logs, site_config.0.auto_heal_enabled, site_config.0.auto_heal_setting, site_config.0.ip_restriction, site_config.0.health_check_path]
  }
}

## VNET integration

resource "azurerm_app_service_virtual_network_swift_connection" "web_app" {
  for_each = toset(var.app_service_names)

  app_service_id = azurerm_windows_web_app.web_app[each.key].id
  subnet_id      = data.azurerm_subnet.service_plan.id
}
