# Peering between Hub 1 and Hub 2
resource "azurerm_virtual_network_peering" "public_to_safe" {
  name                      = "hub1-to-hub2-peering"
  resource_group_name       = azurerm_resource_group.network_rg.name
  virtual_network_name      = azurerm_virtual_network.safe_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.public_vnet.id
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "safe_to_public" {
  name                      = "hub2-to-hub1-peering"
  resource_group_name       = azurerm_resource_group.network_rg.name
  virtual_network_name      = azurerm_virtual_network.safe_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.public_vnet.id
  allow_virtual_network_access = true
}
