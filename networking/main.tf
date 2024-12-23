resource "azurerm_resource_group" "network_rg" {
  name     = "rg-hub-spoke-network"
  location = "israelcentral"
}

# Hub 1 (Public) VNet
resource "azurerm_virtual_network" "public_vnet" {
  name                = "vnet-hub1-public"
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name
  address_space       = ["10.0.0.0/16"]
}

# Subnet for Firewall in Hub 1
resource "azurerm_subnet" "public_fw" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.public_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Hub 2 (Private) VNet
resource "azurerm_virtual_network" "safe_vnet" {
  name                = "vnet-hub2-psafe"
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name
  address_space       = ["10.1.0.0/16"]
}

# Public IP for Hub 2 Firewall
resource "azurerm_public_ip" "safe_fw_pip" {
  name                = "safe-fw-public-ip"
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Subnet for Firewall in Hub 2
resource "azurerm_subnet" "safe_fw" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.safe_vnet.name
  address_prefixes     = ["10.1.1.0/24"]
}

# Subnet for Private Endpoint in Hub 2
resource "azurerm_subnet" "hub2_private_endpoint_subnet" {
  name                 = "safe-safe-endpoint-subnet"
  resource_group_name  = azurerm_resource_group.network_rg.name
  virtual_network_name = azurerm_virtual_network.safe_vnet.name
  address_prefixes     = ["10.1.2.0/24"]
}
