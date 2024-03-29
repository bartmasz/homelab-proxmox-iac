resource "proxmox_virtual_environment_container" "container" {
  for_each = { for container in var.containers_definition :
    "${container.vm_id}-${container.hostname}" => container
  }

  node_name    = var.proxmox_node
  vm_id        = each.value.vm_id
  unprivileged = each.value.unprivileged
  description  = each.value.description
  tags         = each.value.tags

  started       = true
  start_on_boot = true
  startup {
    order      = each.value.startup.order
    up_delay   = each.value.startup.up_delay
    down_delay = each.value.startup.down_delay
  }

  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.debian_container_template.id
    type             = "debian"
  }

  initialization {
    hostname = each.value.hostname
    user_account {
      keys = [file(var.ssh_key_path)]
    }
    ip_config {
      ipv4 {
        address = each.value.ipv4_address
        gateway = each.value.gateway
      }
    }
    dns {
      domain  = var.homelab_domain
      servers = each.value.dns_servers
    }
  }
  features {
    nesting = true
  }
  cpu {
    cores = each.value.cpu_cores
  }
  memory {
    dedicated = each.value.memory_dedicated
  }
  disk {
    datastore_id = var.datastore_container_disk
    size         = each.value.disk_size
  }

  dynamic "mount_point" {
    for_each = each.value.mount_points
    content {
      volume = mount_point.value.volume
      path   = mount_point.value.path
      size   = mount_point.value.size
    }
  }

  network_interface {
    name     = "eth0"
    firewall = true
  }
  console {
    enabled = true
    type    = "shell"
  }
  lifecycle {
    create_before_destroy = false
  }
}
