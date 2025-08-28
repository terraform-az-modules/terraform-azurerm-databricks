##-----------------------------------------------------------------------------
## Outputs
##-----------------------------------------------------------------------------
output "databricks_workspace_id" {
  description = "The ID of the Databricks Workspace in the Azure management plane."
  value       = try(azurerm_databricks_workspace.main[0].id, null)
}

output "databricks_disk_encryption_set_id" {
  description = "The ID of the Managed Disk Encryption Set created by the Databricks Workspace."
  value       = try(azurerm_databricks_workspace.main[0].disk_encryption_set_id, null)
}

output "databricks_managed_disk_identity" {
  description = "The managed_disk_identity block of the Databricks Workspace."
  value       = try(azurerm_databricks_workspace.main[0].managed_disk_identity, null)
}

output "databricks_managed_resource_group_id" {
  description = "The ID of the Managed Resource Group created by the Databricks Workspace."
  value       = try(azurerm_databricks_workspace.main[0].managed_resource_group_id, null)
}

output "databricks_workspace_url" {
  description = "The workspace URL, in the format 'adb-{workspaceId}.{random}.azuredatabricks.net'."
  value       = try(azurerm_databricks_workspace.main[0].workspace_url, null)
}
