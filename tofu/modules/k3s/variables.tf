variable "k3s_config" {
  description = "Configuration for k3s vm"
  type        = object({
    target_node = string
    vm_name     = string
    cloud_init_template = string
    vm_memory   = number
    vm_cores    = number
    vm_state    = string
    vm_disk_size = number
    bridge_network = string
    ip          = string
    ssh_keys    = list(string)
  })
}

