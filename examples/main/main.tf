resource "random_pet" "suffix" {}

resource "random_id" "suffix" {
  byte_length = 8
}

resource "azurerm_resource_group" "this" {
  name     = "test-${random_pet.suffix.id}"
  location = "East US"
  tags = {
    "to_nuke" = "false"
  }
}

resource "azurerm_resource_group" "to_not_nuke" {
  name     = "rg-to-not-nuke-${random_pet.suffix.id}"
  location = "East US"
  tags = {
    "to_nuke" = "false"
  }
}

resource "azurerm_resource_group" "to_not_nuke_2" {
  name     = "rg-to-not-nuke2-${random_pet.suffix.id}"
  location = "East US"
  tags = {
    "to_nuke" = "false"
    "foobar"  = "barfoor"
  }
}

resource "azurerm_resource_group" "to_nuke" {
  name     = "rg-to-nuke-${random_pet.suffix.id}"
  location = "East US"
}

resource "azurerm_resource_group" "to_nuke_2" {
  name     = "rg-to-nuke2-${random_pet.suffix.id}"
  location = "East US"
}


module "azure-function-app-nuke" {
  source = "../../"

  function_app_name             = "fpn-${random_pet.suffix.id}"
  service_plan_name             = "spn-${random_pet.suffix.id}"
  storage_account_name          = "san${random_id.suffix.hex}"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = azurerm_resource_group.this.location
  scheduler_ncrontab_expression = "*/10 * * * *"

  exclude_tags = {
    key   = "to_nuke"
    value = "false"
  }
}
