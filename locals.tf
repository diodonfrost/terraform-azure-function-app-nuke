locals {
  # Generate a storage account name if not provided
  # Format: "funcsa" + random 8-character hex suffix = max 14 characters
  # This ensures we stay within Azure's 3-24 character limit and use only lowercase letters and numbers
  generated_storage_name = var.storage_account_name == null ? "funcsa${random_id.storage_suffix.hex}" : var.storage_account_name

  # Generate a service plan name if not provided and not using external service plan
  # Format: "asp-" + function app name + "-" + random 8-character hex suffix
  # This ensures a meaningful and unique name for the service plan
  generated_service_plan_name = var.service_plan_name == null ? "asp-${var.function_app_name}-${random_id.service_plan_suffix.hex}" : var.service_plan_name
}
