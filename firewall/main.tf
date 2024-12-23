# Azure Firewall in Hub 1 with Public IP association
resource "azurerm_firewall" "hub1_firewall" {
  name                = "firewall-public"
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
  name                = var.firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                      = "firewall-safe-ip-configuration"
    subnet_id                 = var.subnet_id
    public_ip_address_id      = var.public_ip_id
    private_ip_address        = var.private_ip_address
    private_ip_address_allocation = "Dynamic"
  }


# Firewall policy and rules can be added similarly
    # Public IP configuration
    #public_ip_address_id      = azurerm_public_ip.safe_fw_pip.id

    # Private IP configuration (static private IP in the subnet)
  

  # Explicit dependency on subnet creation before firewall creation
  depends_on = [azurerm_subnet.safe_fw]

}
