resource "proxmox_virtual_environment_download_file" "debian_container_template" {
  content_type = "vztmpl"
  datastore_id = var.datastore_container_template
  node_name    = var.proxmox_node
  url          = "http://download.proxmox.com/images/system/debian-12-standard_12.2-1_amd64.tar.zst"

}
