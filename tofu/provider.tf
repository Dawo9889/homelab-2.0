terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.2-rc07"
    }
  }
}
provider "proxmox" {
  pm_api_url = "https://pve.dawo9889-homelab.ovh/api2/json"

  # Rest of the authentication details are sourced from environment variables
}
