##-----------------------------------------------------------------------------
## Naming convention
##-----------------------------------------------------------------------------
variable "custom_name" {
  type        = string
  default     = null
  description = "Override default naming convention"
}

variable "resource_position_prefix" {
  type        = bool
  default     = true
  description = <<EOT
Controls the placement of the resource type keyword (e.g., "vnet", "ddospp") in the resource name.

- If true, the keyword is prepended: "vnet-core-dev".
- If false, the keyword is appended: "core-dev-vnet".

This helps maintain naming consistency based on organizational preferences.
EOT
}

##-----------------------------------------------------------------------------
## Labels
##-----------------------------------------------------------------------------
variable "name" {
  type        = string
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "environment" {
  type        = string
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "managedby" {
  type        = string
  default     = "terraform-az-modules"
  description = "ManagedBy, eg 'terraform-az-modules'."
}

variable "extra_tags" {
  type        = map(string)
  default     = null
  description = "Variable to pass extra tags."
}

variable "repository" {
  type        = string
  default     = "https://github.com/terraform-az-modules/terraform-azure-databricks"
  description = "Terraform current module repo"

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^https://", var.repository))
    error_message = "The module-repo value must be a valid Git repo link."
  }
}

variable "location" {
  type        = string
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
}

variable "deployment_mode" {
  type        = string
  default     = "terraform"
  description = "Specifies how the infrastructure/resource is deployed"
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment", "location"]
  description = "The order of labels used to construct resource names or tags. If not specified, defaults to ['name', 'environment', 'location']."
}


##-----------------------------------------------------------------------------
## Global Variables
##-----------------------------------------------------------------------------
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the network security group."
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
}

##-----------------------------------------------------------------------------
## Databricks
##-----------------------------------------------------------------------------
variable "sku" {
  type        = string
  default     = "trial"
  description = "SKU for the Databricks Workspace. Allowed values: standard, premium, or trial."
}

variable "network_security_group_rules_required" {
  type        = string
  default     = "NoAzureDatabricksRules"
  description = "Specifies NSG rules required for data plane to control plane communication. Valid values: AllRules, NoAzureDatabricksRules, or NoAzureServiceRules. Required when public_network_access_enabled is false."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Enable or disable public network access to the Databricks Workspace."
}

variable "managed_resource_group_name" {
  type        = string
  default     = "databricks-resource-group"
  description = "Name of the managed resource group created for the Databricks Workspace."
}

variable "virtual_network_id" {
  type        = string
  default     = null
  description = "ID of the Virtual Network to associate with the Databricks Workspace."
}

variable "private_subnet_name" {
  type        = string
  default     = null
  description = "Name of the private subnet to be used by the Databricks Workspace."
}

variable "public_subnet_name" {
  type        = string
  default     = null
  description = "Name of the public subnet to be used by the Databricks Workspace."
}

variable "public_subnet_network_security_group_association_id" {
  type        = string
  default     = null
  description = "Resource ID of the NSG association for the public subnet."
}

variable "private_subnet_network_security_group_association_id" {
  type        = string
  default     = null
  description = "Resource ID of the NSG association for the private subnet."
}

variable "no_public_ip" {
  type        = bool
  default     = false
  description = "Set to true to disable public IP allocation for Databricks resources."
}

variable "storage_account_name" {
  type        = string
  default     = "databricks"
  description = "Name of the storage account to be linked with the Databricks Workspace."
}

variable "cluster_enable" {
  type        = bool
  default     = true
  description = "Set to false to prevent creation of the default Databricks cluster."
}

variable "autotermination_minutes" {
  type        = number
  default     = 20
  description = "Number of minutes after which the cluster auto-terminates if idle."
}

variable "num_workers" {
  type        = number
  default     = 0
  description = "Number of worker nodes in the Databricks cluster when autoscaling is disabled."
}

variable "enable_autoscale" {
  type        = bool
  default     = false
  description = "Enable autoscaling for the Databricks cluster."
}

variable "min_workers" {
  type        = number
  default     = 1
  description = "Minimum number of workers for the autoscaling Databricks cluster."
}

variable "max_workers" {
  type        = number
  default     = 2
  description = "Maximum number of workers for the autoscaling Databricks cluster."
}

variable "cluster_profile" {
  type        = string
  default     = "multiNode"
  description = "Type of cluster to deploy. Valid options: 'singleNode' or 'multiNode'."
}

variable "spark_version" {
  type        = string
  default     = null
  description = "Databricks Runtime (Spark) version to use for the cluster. If not set, the latest default version will be used."
}
