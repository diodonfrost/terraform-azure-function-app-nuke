data "azurerm_subscription" "current" {}

resource "random_id" "service_plan_suffix" {
  byte_length = 4
}

resource "azurerm_service_plan" "this" {
  name                = local.generated_service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "Y1"

  tags = var.tags
}

resource "archive_file" "this" {
  type        = "zip"
  source_dir  = "${path.module}/functions/"
  output_path = "${path.module}/functions.zip"
}

resource "terraform_data" "replacement" {
  input = archive_file.this.output_sha
}

resource "azurerm_linux_function_app" "this" {
  name                = var.function_app_name
  resource_group_name = var.resource_group_name
  location            = var.location

  storage_account_name        = azurerm_storage_account.this.name
  storage_account_access_key  = azurerm_storage_account.this.primary_access_key
  service_plan_id             = azurerm_service_plan.this.id
  functions_extension_version = "~4"
  zip_deploy_file             = archive_file.this.output_path

  site_config {
    application_insights_connection_string = var.application_insights != null ? var.application_insights.connection_string : null
    application_insights_key               = var.application_insights != null ? var.application_insights.instrumentation_key : null
    application_stack {
      python_version = var.python_version
    }
    cors {
      allowed_origins = ["https://portal.azure.com"]
    }
  }

  app_settings = {
    SCM_DO_BUILD_DURING_DEPLOYMENT = true
    ENABLE_ORYX_BUILD              = true
    FUNCTIONS_WORKER_RUNTIME       = "python"
    ScheduleAppSetting             = var.scheduler_ncrontab_expression
    CURRENT_SUBSCRIPTION_ID        = data.azurerm_subscription.current.subscription_id
    CURRENT_RESOURCE_GROUP         = var.resource_group_name
    TAG_KEY                        = var.exclude_tags["key"]
    TAG_VALUE                      = var.exclude_tags["value"]
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags

  lifecycle {
    replace_triggered_by = [
      terraform_data.replacement
    ]
  }
}
