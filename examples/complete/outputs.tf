##-----------------------------------------------------------------------------
## Outputs
##-----------------------------------------------------------------------------
output "databricks_workspace_id" {
  description = "The ID of the Databricks Workspace in the Azure management plane."
  value       = module.databricks.databricks_workspace_id
}

output "databricks_disk_encryption_set_id" {
  description = "The ID of the Managed Disk Encryption Set created by the Databricks Workspace."
  value       = module.databricks.databricks_disk_encryption_set_id
}

output "databricks_managed_disk_identity" {
  description = "The managed_disk_identity block of the Databricks Workspace."
  value       = module.databricks.databricks_managed_disk_identity
}

output "databricks_managed_resource_group_id" {
  description = "The ID of the Managed Resource Group created by the Databricks Workspace."
  value       = module.databricks.databricks_managed_resource_group_id
}

output "databricks_workspace_url" {
  description = "The workspace URL, in the format 'adb-{workspaceId}.{random}.azuredatabricks.net'."
  value       = module.databricks.databricks_workspace_url
}
