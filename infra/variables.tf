# ========= #
# Variables #
# ========= #

variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "infra-network"
}

variable "net_cidr" {
  description = "Subnet structure"
  type = list(object({
    name   = string,
    zone   = string,
    prefix = string
  }))

  default = [
    { name = "infra-subnet-b", zone = "ru-central1-b", prefix = "10.130.1.0/24" },
    { name = "infra-subnet-a", zone = "ru-central1-a", prefix = "10.129.1.0/24" },
    { name = "infra-subnet-d", zone = "ru-central1-d", prefix = "10.131.1.0/24" },
  ]
}

variable "vm_1_name" {
  type        = string
  default     = "vm-kittygram"
}

variable "ssh_key" {
  description = "SSH Public Key"
  sensitive   = true
  type        = string
  default     = "changeit"
}

variable "cloud_id" {
  description = "Cloud ID"
  type        = string
  default     = "changeit"
}

variable "folder_id" {
  description = "Folder ID"
  type        = string
  default     = "changeit"
}

variable "image_family" {
  description = "Family of OS"
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "zone" {
  description = "Availability zone for the VM and its subnet"
  type        = string
  default     = "ru-central1-b"
}

variable "cores" {
  description = "Number of CPU cores for the VM"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Amount of RAM (GB) for the VM"
  type        = number
  default     = 2
}

variable "core_fraction" {
  description = "Guaranteed vCPU share in percent for standard-v3: 20, 50, 100"
  type        = number
  default     = 20

  validation {
    condition     = contains([20, 50, 100], var.core_fraction)
    error_message = "For platform standard-v3 core_fraction must be one of: 20, 50, 100."
  }
}

variable "platform_id" {
  description = "VM platform ID"
  type        = string
  default     = "standard-v3"
}

variable "disk_type" {
  description = "Boot disk type"
  type        = string
  default     = "network-hdd"
}

variable "disk_size" {
  description = "Boot disk size (GB)"
  type        = number
  default     = 20
}

variable "nat" {
  description = "Enable public IP for the VM"
  type        = bool
  default     = true
}
