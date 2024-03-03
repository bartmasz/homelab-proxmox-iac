
resource "proxmox_virtual_environment_vm" "k8s_vm" {
  count     = length(var.k8s_cluster_definition)
  node_name = var.proxmox_node
  vm_id     = var.k8s_cluster_definition[count.index].vm_id
  name      = var.k8s_cluster_definition[count.index].hostname
  tags      = concat(var.k8s_cluster_tags, [var.k8s_cluster_definition[count.index].type])

  started = true
  on_boot = true
  startup {
    order      = var.k8s_cluster_definition[count.index].startup.order
    up_delay   = var.k8s_cluster_definition[count.index].startup.up_delay
    down_delay = var.k8s_cluster_definition[count.index].startup.down_delay
  }

  clone {
    vm_id   = var.vm_template_id
    retries = 3
  }

  boot_order = ["scsi0"]

  memory {
    dedicated = var.k8s_cluster_definition[count.index].memory_dedicated
  }

  cpu {
    type  = "host"
    cores = var.k8s_cluster_definition[count.index].cpu_cores
    limit = var.k8s_cluster_definition[count.index].cpu_limit
    units = var.k8s_cluster_definition[count.index].cpu_units
  }

  initialization {
    ip_config {
      ipv4 {
        address = var.k8s_cluster_definition[count.index].ip_address
        gateway = var.proxmox_gateway
      }
    }
  }

  lifecycle {
    ignore_changes = [
      # List of attributes to ignore
      initialization,
    ]
  }
}
