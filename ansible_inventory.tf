resource "local_file" "ansible_inventory" {
  depends_on = [proxmox_virtual_environment_container.container]

  filename        = "${path.module}/inventory.ini"
  file_permission = 644
  content = templatefile(
    "${path.module}/ansible_inventory.tpl",
    {
      containers = local.container_details
    }
  )
}
