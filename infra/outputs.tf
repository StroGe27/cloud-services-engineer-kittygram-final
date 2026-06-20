output "vm_external_ip" {
  description = "Public IP address of the Kittygram VM"
  value       = yandex_compute_instance.kittygram_vm.network_interface[0].nat_ip_address
}

output "vm_internal_ip" {
  description = "Private IP address of the Kittygram VM"
  value       = yandex_compute_instance.kittygram_vm.network_interface[0].ip_address
}

output "storage_bucket_name" {
  description = "Name of the Kittygram Object Storage bucket"
  value       = yandex_storage_bucket.kittygram.bucket
}

output "kittygram_url" {
  description = "URL to access Kittygram after deployment"
  value       = "http://${yandex_compute_instance.kittygram_vm.network_interface[0].nat_ip_address}:${var.gateway_port}"
}
