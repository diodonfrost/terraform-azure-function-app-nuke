resource "random_id" "storage_suffix" {
  byte_length = 4
}

resource "azurerm_storage_account" "this" {
  name                     = local.generated_storage_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}
