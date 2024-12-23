
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"  # Update version based on what you need
    }
  }
}

provider "azurerm" {
  features {}
  tenant_id = var.tenant_id
  subscription_id = var.subscription_id
}

variable "location" {
  default = "israelcentral"
}

variable "tenant_id" {
  description = "51b0f3fd-cffd-40a5-bc17-91881944fc4e"

  default = "51b0f3fd-cffd-40a5-bc17-91881944fc4e"

}
variable "subscription_id" {
  description = "e7028c49-efd1-4a16-a3ba-3bf1e8790f5d"
  default = "e7028c49-efd1-4a16-a3ba-3bf1e8790f5d"
}

