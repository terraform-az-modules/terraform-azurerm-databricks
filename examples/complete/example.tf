provider "azurerm" {
  features {}
}

provider "databricks" {
  azure_workspace_resource_id = module.databricks.databricks_workspace_id
}

##-----------------------------------------------------------------------------
## Resource Group module call
## Resource group in which all resources will be deployed.
##-----------------------------------------------------------------------------
module "resource_group" {
  source      = "terraform-az-modules/resource-group/azurerm"
  version     = "1.0.3"
  name        = "core"
  environment = "dev"
  location    = "centralus"
  label_order = ["name", "environment", "location"]
}

# ------------------------------------------------------------------------------
# Virtual Network
# ------------------------------------------------------------------------------
module "vnet" {
  source              = "terraform-az-modules/vnet/azurerm"
  version             = "1.0.3"
  name                = "core"
  environment         = "dev"
  label_order         = ["name", "environment", "location"]
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_spaces      = ["10.0.0.0/16"]
}

# ------------------------------------------------------------------------------
# Subnet
# ------------------------------------------------------------------------------
module "pub_subnet" {
  source               = "terraform-az-modules/subnet/azurerm"
  version              = "1.0.1"
  environment          = "dev"
  label_order          = ["name", "environment", "location"]
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = module.vnet.vnet_name

  subnets = [
    {
      name                      = "pub-subnet"
      subnet_prefixes           = ["10.0.1.0/24"]
      network_security_group_id = module.public_security_group.id
      nsg_association           = true
      delegations = [
        {
          name = "delegation1"
          service_delegations = [
            {
              name    = "Microsoft.Databricks/workspaces"
              actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
            }
          ]
        }
      ]
    }
  ]
}

# ------------------------------------------------------------------------------
# Subnet
# ------------------------------------------------------------------------------
module "pvt_subnet" {
  source               = "terraform-az-modules/subnet/azurerm"
  version              = "1.0.1"
  environment          = "dev"
  label_order          = ["name", "environment", "location"]
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = module.vnet.vnet_name

  subnets = [
    {
      name                      = "pvt-subnet"
      subnet_prefixes           = ["10.0.2.0/24"]
      network_security_group_id = module.private_security_group.id
      nsg_association           = true
      delegations = [
        {
          name = "delegation1"
          service_delegations = [
            {
              name    = "Microsoft.Databricks/workspaces"
              actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
            }
          ]
        }
      ]
    }
  ]
}

#-----------------------------------------------------------------------------
# Network Security Group
#-----------------------------------------------------------------------------
module "public_security_group" {
  source              = "terraform-az-modules/nsg/azurerm"
  version             = "1.0.1"
  name                = "pub"
  environment         = "dev"
  label_order         = ["name", "environment", "location"]
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
}

#-----------------------------------------------------------------------------
# Network Security Group
#-----------------------------------------------------------------------------
module "private_security_group" {
  source              = "terraform-az-modules/nsg/azurerm"
  version             = "1.0.1"
  name                = "private"
  environment         = "dev"
  label_order         = ["name", "environment", "location"]
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
}

#-----------------------------------------------------------------------------
# Databricks
#-----------------------------------------------------------------------------
module "databricks" {
  source                                               = "./../../"
  name                                                 = "core"
  environment                                          = "dev"
  resource_group_name                                  = module.resource_group.resource_group_name
  location                                             = module.resource_group.resource_group_location
  virtual_network_id                                   = module.vnet.vnet_id
  public_subnet_name                                   = module.pub_subnet.subnet_names.pub-subnet
  private_subnet_name                                  = module.pvt_subnet.subnet_names.pvt-subnet
  public_subnet_network_security_group_association_id  = module.public_security_group.id
  private_subnet_network_security_group_association_id = module.private_security_group.id
  depends_on                                           = [module.private_security_group, module.public_security_group]
}