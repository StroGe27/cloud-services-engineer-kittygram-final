variable "folder_id" {
  type        = string
  description = "Yandex Cloud folder ID"
}

variable "zone" {
  type        = string
  description = "Availability zone for resources"
  default     = "ru-central1-a"
}

variable "ssh_public_key" {
  type        = string
  description = "Public SSH key for VM access"
}

variable "vm_user" {
  type        = string
  description = "Linux user on the VM"
  default     = "yc-user"
}

variable "vm_cores" {
  type        = number
  description = "Number of CPU cores for the VM"
  default     = 2
}

variable "vm_memory" {
  type        = number
  description = "Amount of RAM (GB) for the VM"
  default     = 2
}

variable "vm_disk_size" {
  type        = number
  description = "Boot disk size (GB)"
  default     = 20
}

variable "image_family" {
  type        = string
  description = "OS image family for the VM"
  default     = "ubuntu-2204-lts"
}

variable "gateway_port" {
  type        = number
  description = "HTTP port exposed by the gateway service"
  default     = 80
}
