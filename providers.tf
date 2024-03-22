terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.50.0"
    }
  }
}

provider "proxmox" {
  insecure = true
  ssh {
    agent = true
  }
}
