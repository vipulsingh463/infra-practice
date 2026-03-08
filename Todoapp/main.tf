module "rg" {
  source = "../Modules/resource_group"

  child_groups = var.resource_groups
}

module "vnet" {

  source = "../Modules/virtual_network"

  vnets = var.vnets

}


module "pip" {

  source = "../Modules/public_ip"

  public_ips = var.public_ips

}

module "vm" {

  source = "../Modules/virtual_machine"

  vms = {

    vm1 = {
      name                = "web-vm"
      nic_name            = "web-nic"
      location            = "Central India"
      resource_group_name = "dev-rg"
      subnet_id = "/subscriptions/410df174-57d7-4fa1-bc3d-11f62f6e3845/resourceGroups/dev-rg/providers/Microsoft.Network/virtualNetworks/vnet-dev-centralindia/subnets/web-subnet"
      public_ip_id        = module.pip.pip["pip1"].id
    }

    vm2 = {
      name                = "app-vm"
      nic_name            = "app-nic"
      location            = "Central India"
      resource_group_name = "dev-rg"
      subnet_id = "/subscriptions/410df174-57d7-4fa1-bc3d-11f62f6e3845/resourceGroups/dev-rg/providers/Microsoft.Network/virtualNetworks/vnet-dev-centralindia/subnets/web-subnet"
      public_ip_id        = null
    }

  }

}