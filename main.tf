##-----------------------------------------------------------------------------
# Standard Tagging Module – Applies standard tags to all resources for traceability
##-----------------------------------------------------------------------------
module "labels" {
  source          = "terraform-az-modules/tags/azurerm"
  version         = "1.0.2"
  name            = var.custom_name == null ? var.name : var.custom_name
  location        = var.location
  environment     = var.environment
  managedby       = var.managedby
  label_order     = var.label_order
  repository      = var.repository
  deployment_mode = var.deployment_mode
  extra_tags      = var.extra_tags
}

resource "azurerm_databricks_workspace" "main" {
  count                                 = var.enabled ? 1 : 0
  name                                  = var.resource_position_prefix ? format("dbw-%s", local.name) : format("%s-dbw", local.name)
  location                              = var.location
  resource_group_name                   = var.resource_group_name
  sku                                   = var.sku
  managed_resource_group_name           = var.managed_resource_group_name
  public_network_access_enabled         = var.public_network_access_enabled
  network_security_group_rules_required = var.network_security_group_rules_required
  tags                                  = module.labels.tags
  custom_parameters {
    virtual_network_id                                   = var.virtual_network_id
    private_subnet_name                                  = var.private_subnet_name
    public_subnet_name                                   = var.public_subnet_name
    private_subnet_network_security_group_association_id = var.private_subnet_network_security_group_association_id
    public_subnet_network_security_group_association_id  = var.public_subnet_network_security_group_association_id
    no_public_ip                                         = var.no_public_ip
    storage_account_name                                 = var.storage_account_name
  }
}

resource "databricks_cluster" "cluster" {
  count                   = var.enabled && var.cluster_enable == true ? 1 : 0
  cluster_name            = var.resource_position_prefix ? format("db-cluster-%s", local.name) : format("%s-db-cluster", local.name)
  spark_version           = var.spark_version != null ? var.spark_version : data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  num_workers             = var.enable_autoscale == true ? 0 : var.num_workers
  autotermination_minutes = var.autotermination_minutes
  dynamic "autoscale" {
    for_each = var.enable_autoscale == true ? [1] : [0]
    content {
      min_workers = var.min_workers
      max_workers = var.max_workers
    }
  }
  spark_conf = {
    "spark.databricks.cluster.profile" : var.cluster_profile
    "spark.master" : "local[*]"
  }
  depends_on = [azurerm_databricks_workspace.main]
}