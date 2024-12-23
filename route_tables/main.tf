# Resource Group for Hub 1
resource "azurerm_resource_group" "public_rg" {
  name     = "rg-hub1"
  location = "israelcentral" # Adjust as needed
}

# Resource Group for Hub 2
resource "azurerm_resource_group" "safe_rg" {
  name     = "rg-hub2"
  location = "israelcentral" # Adjust as needed
}

resource "azurerm_route_table" "public_rt" {
  name                = "hub1-public-route-table"
  location            = azurerm_resource_group.public_rg.location
  resource_group_name = azurerm_resource_group.public_rg.name
}

resource "azurerm_route_table" "safe_rt" {
  name                = "hub2-safe--route-table"
  location            = azurerm_resource_group.safe_rg.location
  resource_group_name = azurerm_resource_group.safe_rg.name
}
