resource "azurerm_monitor_diagnostic_setting" "this" {
  count = var.diagnostic_settings == null ? 0 : 1

  name               = var.diagnostic_settings.name
  target_resource_id = azurerm_linux_function_app.this.id

  storage_account_id             = var.diagnostic_settings.storage_account_id
  log_analytics_workspace_id     = var.diagnostic_settings.log_analytics_id
  log_analytics_destination_type = var.diagnostic_settings.log_analytics_destination_type
  eventhub_name                  = var.diagnostic_settings.eventhub_name
  eventhub_authorization_rule_id = var.diagnostic_settings.eventhub_authorization_rule_id

  dynamic "enabled_log" {
    for_each = var.diagnostic_settings.log_categories

    content {
      category = enabled_log.value
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = var.diagnostic_settings.enable_metrics
  }
}
