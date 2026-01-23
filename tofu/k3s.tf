module "k3s" {
  source     = "./modules/k3s"
  for_each   = var.k3_configs
  k3s_config = each.value
}

variable "k3_configs" {
  description = "Map of k3 VM configurations keyed by instance name"
  type = map(object({
    target_node         = string
    vm_name             = string
    cloud_init_template = string
    vm_memory           = number
    vm_cores            = number
    vm_state            = string
    vm_disk_size        = number
    bridge_network      = string
    ip                  = string
    ssh_keys            = list(string)
  }))
  default = {
    node1 = {
      target_node          = "pve2"
      vm_name              = "k3s-node-1"
      cloud_init_template  = "ubuntu-2404-cloudinit"
      vm_memory            = 4096
      vm_cores             = 2
      vm_state             = "started"
      vm_disk_size         = 20
      bridge_network       = "vmbr0"
      ip                   = "ip=192.168.1.10/24,gw=192.168.1.1"
      ssh_keys             = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILhKpbWy7VPP7p7CL0/DdNtrWHnTTogaAfXmNegECbJZ For automation"]
    }
    node2 = {
      target_node          = "pve2"
      vm_name              = "k3s-node-2"
      cloud_init_template  = "ubuntu-2404-cloudinit"
      vm_memory            = 4096
      vm_cores             = 2
      vm_state             = "started"
      vm_disk_size         = 20
      bridge_network       = "vmbr0"
      ip                   = "ip=192.168.1.11/24,gw=192.168.1.1"
      ssh_keys             = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILhKpbWy7VPP7p7CL0/DdNtrWHnTTogaAfXmNegECbJZ For automation"]
    }
    node3 = {
      target_node          = "pve"
      vm_name              = "k3s-node-3"
      cloud_init_template  = "ubuntu-2404-cloudinit"
      vm_memory            = 2048
      vm_cores             = 2
      vm_state             = "started"
      vm_disk_size         = 20
      bridge_network       = "vmbr0"
      ip                   = "ip=192.168.1.12/24,gw=192.168.1.1"
      ssh_keys             = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILhKpbWy7VPP7p7CL0/DdNtrWHnTTogaAfXmNegECbJZ For automation"]
    }
  }
}
