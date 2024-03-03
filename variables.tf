# node
variable "proxmox_node" {
  type = string
}
variable "homelab_domain" {
  type    = string
  default = "homelab.local"
}

# ssh
variable "vm_template_cloud_init_ssh_key_path" {
  type    = string
  default = "~/.ssh/id_ed25519.pub"
}

# data stores
variable "datastore_container_template" {
  type    = string
  default = "local"
}
variable "datastore_container_disk" {
  type    = string
  default = "local-lvm"
}

# containers
variable "containers_definition" {
  type = list(object({
    vm_id        = number
    hostname     = string
    description  = string
    unprivileged = bool
    disk_size    = number
    mount_points = list(object({
      volume = string
      path   = string
    }))
    ipv4_address     = string
    gateway          = string
    dns_servers      = list(string)
    cpu_cores        = number
    memory_dedicated = number
    tags             = list(string)
  }))
}
