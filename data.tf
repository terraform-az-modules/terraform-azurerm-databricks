##-----------------------------------------------------------------------------
## Data
##-----------------------------------------------------------------------------
data "databricks_node_type" "smallest" {
  local_disk = true
  depends_on = [azurerm_databricks_workspace.main]
}

data "databricks_spark_version" "latest_lts" {
  long_term_support = true
  depends_on        = [azurerm_databricks_workspace.main]
}
