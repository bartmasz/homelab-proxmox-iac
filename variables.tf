# node
variable "proxmox_node" {
  type = string
}

# data stores
variable "datastore_container_template" {
  type    = string
  default = "local"
}
