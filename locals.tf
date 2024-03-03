locals {
  container_details = [for ct in proxmox_virtual_environment_container.container : {
    vm_id        = ct.vm_id
    hostname     = ct.initialization[0].hostname
    ipv4_address = split("/", ct.initialization[0].ip_config[0].ipv4[0].address)[0]
  }]
}
