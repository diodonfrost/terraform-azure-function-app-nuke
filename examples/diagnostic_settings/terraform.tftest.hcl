run "create_test_infrastructure" {
  command = apply

  assert {
    condition     = module.to_event_hub.resource_group_name == azurerm_resource_group.test.name
    error_message = "Invalid resource group name"
  }

  assert {
    condition     = module.to_event_hub.function_app_name == "fpn-to-event-hub-${random_pet.suffix.id}"
    error_message = "Invalid function app name"
  }

  assert {
    condition     = module.to_event_hub.diagnostic_settings_name == "test-${random_pet.suffix.id}"
    error_message = "Invalid diagnostic settings name"
  }

  assert {
    condition     = module.to_event_hub.diagnostic_settings_target_resource_id == module.to_event_hub.function_app_id
    error_message = "Invalid diagnostic settings target resource ID"
  }

  assert {
    condition     = module.to_log_analytic.resource_group_name == azurerm_resource_group.test.name
    error_message = "Invalid resource group name"
  }

  assert {
    condition     = module.to_log_analytic.function_app_name == "fpn-to-log-analytic-${random_pet.suffix.id}"
    error_message = "Invalid function app name"
  }

  assert {
    condition     = module.to_log_analytic.diagnostic_settings_name == "test-${random_pet.suffix.id}"
    error_message = "Invalid diagnostic settings name"
  }

  assert {
    condition     = module.to_log_analytic.diagnostic_settings_target_resource_id == module.to_log_analytic.function_app_id
    error_message = "Invalid diagnostic settings target resource ID"
  }

  assert {
    condition     = module.to_storage_account.resource_group_name == azurerm_resource_group.test.name
    error_message = "Invalid resource group name"
  }

  assert {
    condition     = module.to_storage_account.function_app_name == "fpn-to-storage-account-${random_pet.suffix.id}"
    error_message = "Invalid function app name"
  }

  assert {
    condition     = module.to_storage_account.diagnostic_settings_name == "test-${random_pet.suffix.id}"
    error_message = "Invalid diagnostic settings name"
  }

  assert {
    condition     = module.to_storage_account.diagnostic_settings_target_resource_id == module.to_storage_account.function_app_id
    error_message = "Invalid diagnostic settings target resource ID"
  }
}
