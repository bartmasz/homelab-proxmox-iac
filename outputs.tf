output "container_details" {
  value     = local.container_details
  sensitive = false
}
output "k8s_manager_details" {
  value = local.manager_details
}
output "k8s_worker_details" {
  value = local.worker_details
}
