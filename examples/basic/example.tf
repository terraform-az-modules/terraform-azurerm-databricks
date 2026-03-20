provider "azurerm" {
  features {}
}

module "databricks" {
  source = "../../"
}
