locals {
  container_details = [for ct in proxmox_virtual_environment_container.container : {
    vm_id        = ct.vm_id
    hostname     = ct.initialization[0].hostname
    ipv4_address = split("/", ct.initialization[0].ip_config[0].ipv4[0].address)[0]
  }]

  k8s_vms = [for vm in proxmox_virtual_environment_vm.k8s_vm : {
    name = vm.name
    tags = flatten(vm.tags)
    ip   = [for ip in flatten(vm.ipv4_addresses) : ip if ip != "127.0.0.1"][0]
  } if contains(vm.tags, "k8s")]

  manager_details = [for vm in local.k8s_vms : vm if contains(vm.tags, "manager")]
  worker_details  = [for vm in local.k8s_vms : vm if contains(vm.tags, "worker")]
}
