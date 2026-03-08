resource "azurerm_network_interface" "nic" {

  for_each = var.vms

  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {

    name                          = "internal"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = each.value.public_ip_id

  }

}

resource "azurerm_linux_virtual_machine" "vm" {

  for_each = var.vms

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  size = "Standard_D2s_v3"

  admin_username = "azureuser"
  admin_password = "Password@1234"

  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

}