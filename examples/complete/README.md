<!-- BEGIN_TF_DOCS -->

# Terraform Azure DataBricks

This directory contains an example usage of the **terraform-azure-databricks**. It demonstrates how to use the module with default settings or with custom configurations.

---

## 📋 Requirements

| Name      | Version   |
|-----------|-----------|
| Terraform | >= 1.6.6  |
| Azurerm   | >= 4.11.0 |

---

## 🔌 Providers

None specified in this example.

---

## 📦 Modules

| Name                   | Source                                    | Version |
|------------------------|-------------------------------------------|---------|
| resource_group         | terraform-az-modules/resource-group/azure | 1.0.0   |
| vnet                   | terraform-az-modules/vnet/azure          | 1.0.0   |
| pub_subnet             | terraform-az-modules/subnet/azure        | 1.0.0   |
| pvt_subnet             | terraform-az-modules/subnet/azure        | 1.0.0   |
| public_security_group  | terraform-az-modules/nsg/azure           | 1.0.0   |
| private_security_group | terraform-az-modules/nsg/azure           | 1.0.0   |
| databricks             | ./../../                                  | n/a     |

## 🏗️ Resources

No resources are directly created in this example.

---

## 🔧 Inputs

No input variables are defined in this example.

---
## 📤 Outputs


| Name                                | Description                                                                          |
|-------------------------------------|--------------------------------------------------------------------------------------|
| databricks_workspace_id             | The ID of the Databricks Workspace in the Azure management plane.                    |
| databricks_disk_encryption_set_id   | The ID of the Managed Disk Encryption Set created by the Databricks Workspace.       |
| databricks_managed_disk_identity    | The managed_disk_identity block of the Databricks Workspace.                         |
| databricks_managed_resource_group_id| The ID of the Managed Resource Group created by the Databricks Workspace.            |
| databricks_workspace_url            | The workspace URL, in the format 'adb-{workspaceId}.{random}.azuredatabricks.net'.   |


<!-- END_TF_DOCS -->
