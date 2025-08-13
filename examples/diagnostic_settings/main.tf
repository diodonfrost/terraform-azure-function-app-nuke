resource "random_pet" "suffix" {}

resource "random_id" "suffix" {
  byte_length = 6
}

resource "azurerm_resource_group" "test" {
  name     = "test-${random_pet.suffix.id}"
  location = "swedencentral"

  tags = {
    do_not_delete = "true"
  }
}

resource "azurerm_log_analytics_workspace" "test" {
  name                = "test-${random_pet.suffix.id}"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_eventhub_namespace" "test" {
  name                = "test-${random_pet.suffix.id}"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  sku                 = "Basic"
  capacity            = 1
}

resource "azurerm_eventhub" "test" {
  name                = "acceptanceTestEventHub"
  namespace_name      = azurerm_eventhub_namespace.test.name
  resource_group_name = azurerm_resource_group.test.name
  partition_count     = 1
  message_retention   = 1
}

resource "azurerm_eventhub_namespace_authorization_rule" "test" {
  name                = "azure-function"
  namespace_name      = azurerm_eventhub_namespace.test.name
  resource_group_name = azurerm_resource_group.test.name
  listen              = false
  send                = true
  manage              = false
}

resource "azurerm_storage_account" "test" {
  name                     = random_id.suffix.hex
  resource_group_name      = azurerm_resource_group.test.name
  location                 = azurerm_resource_group.test.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


module "to_event_hub" {
  source = "../../"

  function_app_name             = "fpn-${random_pet.suffix.id}"
  service_plan_name             = "spn-${random_pet.suffix.id}"
  storage_account_name          = "san${random_id.suffix.hex}"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = azurerm_resource_group.this.location
  scheduler_ncrontab_expression = "*/10 * * * *"
  exclude_tags = {
    key   = "do_not_delete"
    value = "true"
  }
  diagnostic_settings = {
    name                           = "test-${random_pet.suffix.id}"
    eventhub_name                  = azurerm_eventhub.test.name
    eventhub_authorization_rule_id = azurerm_eventhub_namespace_authorization_rule.test.id
  }
  application_insights = {
    enabled                    = true
    log_analytics_workspace_id = azurerm_log_analytics_workspace.test.id
  }
}

module "to_log_analytic" {
  source = "../../"

  function_app_name             = "fpn-${random_pet.suffix.id}"
  service_plan_name             = "spn-${random_pet.suffix.id}"
  storage_account_name          = "san${random_id.suffix.hex}"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = azurerm_resource_group.this.location
  scheduler_ncrontab_expression = "*/10 * * * *"
  exclude_tags = {
    key   = "do_not_delete"
    value = "true"
  }
  diagnostic_settings = {
    name             = "test-${random_pet.suffix.id}"
    log_analytics_id = azurerm_log_analytics_workspace.test.id
  }
  application_insights = {
    enabled                    = true
    log_analytics_workspace_id = azurerm_log_analytics_workspace.test.id
  }
}

module "to_storage_account" {
  source = "../../"

  function_app_name             = "fpn-${random_pet.suffix.id}"
  service_plan_name             = "spn-${random_pet.suffix.id}"
  storage_account_name          = "san${random_id.suffix.hex}"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = azurerm_resource_group.this.location
  scheduler_ncrontab_expression = "*/10 * * * *"
  exclude_tags = {
    key   = "do_not_delete"
    value = "true"
  }
  diagnostic_settings = {
    name               = "test-${random_pet.suffix.id}"
    storage_account_id = azurerm_storage_account.test.id
  }
  application_insights = {
    enabled                    = true
    log_analytics_workspace_id = azurerm_log_analytics_workspace.test.id
  }
}
