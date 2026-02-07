variable "function_app_name" {
  type        = string
  description = "The prefix of the Azure Function App name"
}

variable "service_plan_name" {
  type        = string
  description = "The name of the Azure service plan"
  default     = null
}

variable "storage_account_name" {
  type        = string
  description = "The backend storage account name which will be used by this Function App"
  default     = null
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the Linux Function App should exist"
}

variable "location" {
  type        = string
  description = "The location of the Azure resources"
}

variable "python_version" {
  type        = string
  description = "The Python version to use for the Azure Function App"
  default     = "3.12"
}

variable "application_insights" {
  description = "Configuration for using an existing external Application Insights."
  type = object({
    connection_string   = string
    instrumentation_key = string
  })
  default = null
}

variable "scheduler_ncrontab_expression" {
  description = "The NCRONTAB expression which defines the schedule of the Azure function app"
  type        = string
  default     = "0 0 22 * * 5"
}

variable "exclude_tags" {
  type = object({
    key   = string
    value = string
  })
  description = "Exclude resources with these tags"
  default     = null
}

variable "diagnostic_settings" {
  description = "Diagnostic settings for the function app"
  type = object({
    name                           = string
    storage_account_id             = optional(string, null)
    log_analytics_id               = optional(string, null)
    log_analytics_destination_type = optional(string, null)
    eventhub_name                  = optional(string, null)
    eventhub_authorization_rule_id = optional(string, null)
    log_categories                 = optional(list(string), ["FunctionAppLogs"])
    enable_metrics                 = optional(bool, false)
  })
  default = null
}

variable "tags" {
  type        = map(string)
  description = "The tags to apply to the Azure resources"
  default     = {}
}
