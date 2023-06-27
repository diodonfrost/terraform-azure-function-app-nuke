resource "azurerm_role_definition" "this" {
  name        = azurerm_linux_function_app.this.name
  scope       = data.azurerm_subscription.current.id
  description = "Custom role to delete all resource groups"

  permissions {
    actions = [
      "Microsoft.Resources/subscriptions/resourceGroups/delete",
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Storage/storageAccounts/blobServices/containers/write"
    ]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.current.id
  ]
}

resource "azurerm_role_assignment" "this" {
  scope              = data.azurerm_subscription.current.id
  role_definition_id = azurerm_role_definition.this.role_definition_resource_id
  principal_id       = azurerm_linux_function_app.this.identity[0].principal_id
}
