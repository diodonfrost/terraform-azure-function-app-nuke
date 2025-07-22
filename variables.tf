variable "function_app_name" {
  type        = string
  description = "The prefix of the Azure Function App name"
}

variable "service_plan_name" {
  type        = string
  description = "The name of the Azure service plan"
}

variable "storage_account_name" {
  type        = string
  description = "The backend storage account name which will be used by this Function App"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the Linux Function App should exist"
}

variable "location" {
  type        = string
  description = "The location of the Azure resources"
}

variable "application_insights" {
  description = "Application Insights parameters."
  type = object({
    enabled                    = optional(bool, false)
    log_analytics_workspace_id = optional(string, null)
  })
  default = {}
}

variable "scheduler_ncrontab_expression" {
  description = "The NCRONTAB expression which defines the schedule of the Azure function app"
  type        = string
  default     = "0 22 ? * MON-FRI *"
}

variable "exclude_tags" {
  type = object({
    key   = string
    value = string
  })
  description = "Exclude resources with these tags"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "The tags to apply to the Azure resources"
  default     = {}
}
