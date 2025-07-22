locals {
  # Generate a storage account name if not provided
  # Format: "funcsa" + random 8-character hex suffix = max 14 characters
  # This ensures we stay within Azure's 3-24 character limit and use only lowercase letters and numbers
  generated_storage_name = var.storage_account_name == null ? "funcsa${random_id.storage_suffix.hex}" : var.storage_account_name
}
