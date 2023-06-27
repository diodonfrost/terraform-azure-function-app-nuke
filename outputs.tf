output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.this.name
}

output "service_plan_id" {
  description = "The ID of the service plan"
  value       = azurerm_service_plan.this.id
}

output "service_plan_name" {
  description = "The name of the service plan"
  value       = azurerm_service_plan.this.name
}

output "function_app_id" {
  description = "The ID of the function app"
  value       = azurerm_linux_function_app.this.id
}

output "function_app_name" {
  description = "The name of the function app"
  value       = azurerm_linux_function_app.this.name
}

output "application_insights_id" {
  description = "ID of the associated Application Insights"
  value       = azurerm_application_insights.this.id
}

output "application_insights_name" {
  description = "Name of the associated Application Insights"
  value       = azurerm_application_insights.this.name
}
