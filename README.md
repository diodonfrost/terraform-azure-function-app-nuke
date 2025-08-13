# terraform-azure-function-app-nuke

[![CI](https://github.com/diodonfrost/terraform-azure-function-app-nuke/workflows/CI/badge.svg)](https://github.com/diodonfrost/terraform-azure-function-app-nuke)

Terraform module which create an Azure function app which nuke all resources group on the current subscription.


## Usage
```hcl
module "azure-function-app-nuke" {
  source = "diodonfrost/function-app-nuke/azure"

  function_app_name             = "my-function-app-name-suffix"
  service_plan_name             = "my-service-plan-name"
  resource_group_name           = "my-resource-group-name"
  location                      = "my-azure-location"
  scheduler_ncrontab_expression = "0 22 ? * MON-FRI *"

  exclude_tags = {
    key   = "to_exclude"
    value = "true"
  }
}
```

## Examples

*   [Compute-nuke](https://github.com/diodonfrost/terraform-azure-function-app-nuke/tree/master/examples/resource_group) - Create an Azure Function that will delete all resource groups from the current subscription except those with the tag {"to_exclude": "true"}.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | 2.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0.0, < 4.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0.0, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.3.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.61.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.2 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_application_insights.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_linux_function_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [azurerm_service_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [random_id.service_plan_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.storage_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [terraform_data.replacement](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [archive_file.this](https://registry.terraform.io/providers/hashicorp/archive/2.3.0/docs/data-sources/file) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_insights"></a> [application\_insights](#input\_application\_insights) | Application Insights parameters. | <pre>object({<br/>    enabled                    = optional(bool, false)<br/>    log_analytics_workspace_id = optional(string, null)<br/>  })</pre> | `{}` | no |
| <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings) | Diagnostic settings for the function app | <pre>object({<br/>    name                           = string<br/>    storage_account_id             = optional(string, null)<br/>    log_analytics_id               = optional(string, null)<br/>    log_analytics_destination_type = optional(string, null)<br/>    eventhub_name                  = optional(string, null)<br/>    eventhub_authorization_rule_id = optional(string, null)<br/>    log_categories                 = optional(list(string), ["FunctionAppLogs"])<br/>    enable_metrics                 = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_exclude_tags"></a> [exclude\_tags](#input\_exclude\_tags) | Exclude resources with these tags | <pre>object({<br/>    key   = string<br/>    value = string<br/>  })</pre> | `null` | no |
| <a name="input_function_app_name"></a> [function\_app\_name](#input\_function\_app\_name) | The prefix of the Azure Function App name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location of the Azure resources | `string` | n/a | yes |
| <a name="input_python_version"></a> [python\_version](#input\_python\_version) | The Python version to use for the Azure Function App | `string` | `"3.12"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Resource Group where the Linux Function App should exist | `string` | n/a | yes |
| <a name="input_scheduler_ncrontab_expression"></a> [scheduler\_ncrontab\_expression](#input\_scheduler\_ncrontab\_expression) | The NCRONTAB expression which defines the schedule of the Azure function app | `string` | `"0 22 ? * MON-FRI *"` | no |
| <a name="input_service_plan_name"></a> [service\_plan\_name](#input\_service\_plan\_name) | The name of the Azure service plan | `string` | `null` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The backend storage account name which will be used by this Function App | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to apply to the Azure resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_insights_id"></a> [application\_insights\_id](#output\_application\_insights\_id) | ID of the associated Application Insights |
| <a name="output_application_insights_name"></a> [application\_insights\_name](#output\_application\_insights\_name) | Name of the associated Application Insights |
| <a name="output_function_app_id"></a> [function\_app\_id](#output\_function\_app\_id) | The ID of the function app |
| <a name="output_function_app_name"></a> [function\_app\_name](#output\_function\_app\_name) | The name of the function app |
| <a name="output_service_plan_id"></a> [service\_plan\_id](#output\_service\_plan\_id) | The ID of the service plan |
| <a name="output_service_plan_name"></a> [service\_plan\_name](#output\_service\_plan\_name) | The name of the service plan |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | The ID of the storage account |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | The name of the storage account |
<!-- END_TF_DOCS -->

## Authors

Modules managed by [diodonfrost](https://github.com/diodonfrost)

## Licence

Apache 2 Licensed. See LICENSE for full details.

## Resources

* [python function app](https://docs.microsoft.com/en-us/azure/azure-functions/functions-create-first-function-python)
