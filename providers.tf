terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.47.0"
    }
  }
}

provider "proxmox" {
  insecure = true
  ssh {
    agent = true
  }
}
