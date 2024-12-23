# Create a Grandchild Management Group under Platform Services
resource "azurerm_management_group" "connectivity" {
  name = "connectivity"
}
  #parent_management_group_id = azurerm_management_group.platform_services.id



  # Resource Group
resource "azurerm_resource_group" "pnetwork_rg" {
  name     = "rg-hub-spoke-network-public"
  location = "israelcentral"
}

resource "azurerm_resource_group" "network_rg" {
  name     = "rg-hub-spoke-network-internal"
  location = "israelcentral"
}

