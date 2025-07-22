terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0, < 4.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0, < 4.0"
    }
  }
}
