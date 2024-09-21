provider "azurerm" {
  features {
  }
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}
provider "random" {

}

#Random ID for unique resource names

resource "random_id" "random" {
  keepers = {
    my_value = "constant"

  }
  byte_length = 4
}

resource "azurerm_resource_group" "tfresource_group" {
  name     = "example-rg-${replace("terraform_example", "_", "-")}"
  location = lookup(var.location_map, var.env, "South India")

}


resource "azurerm_virtual_network" "tfvent" {
  name                = format("vnet-%s-%s", var.env, random_id.random.hex)
  resource_group_name = azurerm_resource_group.tfresource_group.name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.tfresource_group.location
  depends_on          = [azurerm_resource_group.tfresource_group]
}

# resource "azurerm_subnet" "tfsubnet" {
#   count                = length(var.subnet_names)
#   name                 = var.subnet_names[count.index]
#   resource_group_name  = azurerm_resource_group.tfresource_group.name
#   virtual_network_name = azurerm_virtual_network.tfvent.name
#   address_prefixes     = 
#   depends_on           = [azurerm_virtual_network.tfvent]
# }

# resource "azurerm_storage_account" "tfstorageaccount" {
#   name                     = lower(join("", ["examplestorage", random_id.random.hex]))
#   resource_group_name      = azurerm_resource_group.tfresource_group.name
#   location                 = azurerm_resource_group.tfresource_group.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   tags = {
#     "environment" : var.env
#     "timestamp" : timestamp()
#   }
#   depends_on = [azurerm_resource_group.tfresource_group, azurerm_virtual_network.tfvent, azurerm_subnet.tfsubnet]

# }

output "address_space" {

  value = [for subnet in tolist(azurerm_virtual_network.tfvent.address_space) : cidrhost(subnet, 5)]

}

# output "storage_account" {
#   value = join(":", [azurerm_storage_account.tfstorageaccount.id, azurerm_storage_account.tfstorageaccount.name])

# }

output "resource_group_name" {
  value = upper(azurerm_resource_group.tfresource_group.name)

}

# output "subnet_cidrs" {
#   value = [for i in azurerm_subnet.tfsubnet.address_prefixes : cidrhost(i.address_prefixes[0], 5)]

# }



