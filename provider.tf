


provider "azurerm" {
  subscription_id = "d505c115-1519-4c95-8321-f1dd40e2b442"
  client_id = "5aa1e2fb-bd0e-46ac-b86d-bffa540b84e9"
  client_secret = "M0x8Q~~J.JllUzK3dqfeyIwTogrKJ0o9Sy32IdnG"
  tenant_id = "6b8b8296-bdff-4ad8-93ad-84bcbf3842f5"
  features {}
}

locals {
  count=3
  location="East US"
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = local.location
}
