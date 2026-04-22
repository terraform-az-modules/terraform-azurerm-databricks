## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| autotermination\_minutes | Number of minutes after which the cluster auto-terminates if idle. | `number` | `20` | no |
| cluster\_enable | Set to false to prevent creation of the default Databricks cluster. | `bool` | `true` | no |
| cluster\_profile | Type of cluster to deploy. Valid options: 'singleNode' or 'multiNode'. | `string` | `"multiNode"` | no |
| custom\_name | Override default naming convention | `string` | `null` | no |
| deployment\_mode | Specifies how the infrastructure/resource is deployed | `string` | `"terraform"` | no |
| enable\_autoscale | Enable autoscaling for the Databricks cluster. | `bool` | `false` | no |
| enabled | Set to false to prevent the module from creating any resources. | `bool` | `true` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `"dev"` | no |
| extra\_tags | Variable to pass extra tags. | `map(string)` | `null` | no |
| label\_order | The order of labels used to construct resource names or tags. If not specified, defaults to ['name', 'environment', 'location']. | `list(any)` | <pre>[<br>  "name",<br>  "environment",<br>  "location"<br>]</pre> | no |
| location | The location/region where the virtual network is created. Changing this forces a new resource to be created. | `string` | n/a | yes |
| managed\_resource\_group\_name | Name of the managed resource group created for the Databricks Workspace. | `string` | `"databricks-resource-group"` | no |
| managedby | ManagedBy, eg 'terraform-az-modules'. | `string` | `"terraform-az-modules"` | no |
| max\_workers | Maximum number of workers for the autoscaling Databricks cluster. | `number` | `2` | no |
| min\_workers | Minimum number of workers for the autoscaling Databricks cluster. | `number` | `1` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `"core"` | no |
| network\_security\_group\_rules\_required | Specifies NSG rules required for data plane to control plane communication. Valid values: AllRules, NoAzureDatabricksRules, or NoAzureServiceRules. Required when public\_network\_access\_enabled is false. | `string` | `"NoAzureDatabricksRules"` | no |
| no\_public\_ip | Set to true to disable public IP allocation for Databricks resources. | `bool` | `false` | no |
| num\_workers | Number of worker nodes in the Databricks cluster when autoscaling is disabled. | `number` | `0` | no |
| private\_subnet\_name | Name of the private subnet to be used by the Databricks Workspace. | `string` | `null` | no |
| private\_subnet\_network\_security\_group\_association\_id | Resource ID of the NSG association for the private subnet. | `string` | `null` | no |
| public\_network\_access\_enabled | Enable or disable public network access to the Databricks Workspace. | `bool` | `false` | no |
| public\_subnet\_name | Name of the public subnet to be used by the Databricks Workspace. | `string` | `null` | no |
| public\_subnet\_network\_security\_group\_association\_id | Resource ID of the NSG association for the public subnet. | `string` | `null` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/terraform-az-modules/terraform-azure-databricks"` | no |
| resource\_group\_name | The name of the resource group in which to create the network security group. | `string` | n/a | yes |
| resource\_position\_prefix | Controls the placement of the resource type keyword (e.g., "vnet", "ddospp") in the resource name.<br><br>- If true, the keyword is prepended: "vnet-core-dev".<br>- If false, the keyword is appended: "core-dev-vnet".<br><br>This helps maintain naming consistency based on organizational preferences. | `bool` | `true` | no |
| sku | SKU for the Databricks Workspace. Allowed values: standard, premium, or trial. | `string` | `"trial"` | no |
| spark\_version | Databricks Runtime (Spark) version to use for the cluster. If not set, the latest default version will be used. | `string` | `null` | no |
| storage\_account\_name | Name of the storage account to be linked with the Databricks Workspace. | `string` | `"databricks"` | no |
| virtual\_network\_id | ID of the Virtual Network to associate with the Databricks Workspace. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| databricks\_disk\_encryption\_set\_id | The ID of the Managed Disk Encryption Set created by the Databricks Workspace. |
| databricks\_managed\_disk\_identity | The managed\_disk\_identity block of the Databricks Workspace. |
| databricks\_managed\_resource\_group\_id | The ID of the Managed Resource Group created by the Databricks Workspace. |
| databricks\_workspace\_id | The ID of the Databricks Workspace in the Azure management plane. |
| databricks\_workspace\_url | The workspace URL, in the format 'adb-{workspaceId}.{random}.azuredatabricks.net'. |

