# Azure Firewall in Hub 1 with Public IP association
resource "azurerm_firewall" "hub1_firewall" {
  name                = "firewall-hub1"
  location            = azurerm_resource_group.public_rg.location
  resource_group_name = azurerm_resource_group.public_rg.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "firewall-ip-configuration"
    subnet_id            = azurerm_subnet.public_fw.id
    public_ip_address_id = azurerm_public_ip.public_waf_pip.id
  }
}

 # Azure Firewall Configuration in the Private Hub
resource "azurerm_firewall" "safe_firewall" {
  name                = "firewall-safe"
  location            = azurerm_resource_group.safe_rg.location
  resource_group_name = azurerm_resource_group.safe_rg.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                      = "firewall-safe-ip-configuration"
    subnet_id                 = azurerm_subnet.safe_fw.id
    public_ip_address_id      = azurerm_public_ip.safe_fw_pip.id
  }

  # Explicit dependency on subnet creation before firewall creation
  depends_on = [azurerm_subnet.safe_fw]
}

