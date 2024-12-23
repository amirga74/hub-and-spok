# main.tf



# Define resource group for public and private resources
#resource "azurerm_resource_group" "public_rg" {
 # name     = "public-resources"
 # location = "israelcentral"
#}

#resource "azurerm_resource_group" "private_rg" {
 # name     = "private-resources"
#  location = "israelcentral"
#}

# Call Networking Module
module "networking" {
  source              = "./networking"
  vnet_name           = "public-vnet"
  location           = azurerm_resource_group.public_rg.location
  resource_group_name = azurerm_resource_group.public_rg.name
  address_space       = ["10.0.0.0/16"]
  subnet_name         = "public-subnet"
  subnet_address_prefix = ["10.0.1.0/24"]
}

# Call Route Tables Module
module "route_table" {
  source              = "./route_tables"
  route_table_name    = "rg-hub-public"
  location            = azurerm_resource_group.public_rg.location
  resource_group_name = azurerm_resource_group.public_rg.name
  route_name          = "public-route"
  address_prefix      = "10.0.0.0/16"
  next_hop_ip_address = "10.1.0.4"
}

# Call Firewall Module
module "firewall" {
  source              = "./firewall"
  firewall_name       = "firewall-public"
  location            = azurerm_resource_group.public_rg.location
  resource_group_name = azurerm_resource_group.public_rg.name
  virtual_network_id  = module.networking.vnet.id
   policy_name         = "public-firewall-policy"
 rule_collection_name = "public-rule-collection"
 rule_name           = "allow-http"
  source_addresses    = ["*"]
  destination_fqdns  = ["www.example.com"]
  protocols           = ["http"]
  }
 

