# node
variable "proxmox_node" {
  type = string
}
variable "homelab_domain" {
  type    = string
  default = "homelab.local"
}

# ssh
variable "ssh_key_path" {
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
variable "datastore_iso" {
  type    = string
  default = "local"
}
variable "vendor_cloud_config_datastore" {
  type    = string
  default = "local"
}
variable "vm_datastore" {
  type    = string
  default = "local-lvm"
}

# cloud image
variable "cloud_image_source_url" {
  type    = string
  default = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
}
variable "cloud_image_source_filename" {
  type    = string
  default = "debian-12-generic-amd64.img"
}

# vm template
variable "vm_template_id" {
  type    = number
  default = 9001
}
variable "vm_template_name" {
  type    = string
  default = "debian-cloud-image"
}
variable "vm_template_description" {
  type    = string
  default = "Debian Cloud Image managed by Terraform"
}
variable "vm_template_tags" {
  type    = list(string)
  default = ["terraform"]
}
variable "vm_template_cloud_init_domain" {
  type = string
}
variable "vm_template_cloud_init_servers" {
  type = list(string)
}
variable "vm_template_cloud_init_username" {
  type = string
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
      size   = string
    }))
    ipv4_address     = string
    gateway          = string
    dns_servers      = list(string)
    cpu_cores        = number
    memory_dedicated = number
    tags             = list(string)
  }))
}
