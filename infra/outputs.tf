output "vm_external_ip" {
  description = "Public IP address of the VM"
  value       = yandex_compute_instance.vm_1.network_interface[0].nat_ip_address
}

output "vm_ssh_command" {
  description = "Example SSH command"
  value       = "ssh user@${yandex_compute_instance.vm_1.network_interface[0].nat_ip_address}"
}
