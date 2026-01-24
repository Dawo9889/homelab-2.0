terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.2-rc07"
    }
  }
}
resource "proxmox_vm_qemu" "k3s_vm" {
  target_node = var.k3s_config.target_node
  name        = var.k3s_config.vm_name

  clone       = var.k3s_config.cloud_init_template
  full_clone  = true

  scsihw      = "virtio-scsi-pci"
  os_type     = "cloud-init"

  agent      = 1

  memory      = var.k3s_config.vm_memory
  cpu {
    cores = var.k3s_config.vm_cores
    type  = "host"
  }

  network {
    id = 0
    model  = "virtio"
    bridge = var.k3s_config.bridge_network
    tag = 0
    macaddr = var.k3s_config.mac_address
  }
  ipconfig0 = var.k3s_config.ip
  sshkeys = join("\n", var.k3s_config.ssh_keys)

  disks {
    scsi {
      scsi0 {
        disk {
          size      = var.k3s_config.vm_disk_size
          storage   = "local-lvm"
          replicate = "true"
        }
      }
    }
    ide {
      ide0 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }
  serial {
    id   = 0
    type = "socket"
  }

  startup_shutdown {
    order = -1
    shutdown_timeout = -1
    startup_delay = -1
  }

  tags = "k3s"
}