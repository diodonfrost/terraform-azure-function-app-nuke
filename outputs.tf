output "resource_group_name" {
  description = "The name of the resource group"
  value       = var.resource_group_name
}

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
