data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}

resource "yandex_vpc_network" "kittygram_network" {
  name = "kittygram-network"
}

resource "yandex_vpc_subnet" "kittygram_subnet" {
  name           = "kittygram-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.kittygram_network.id
  v4_cidr_blocks = ["10.128.0.0/24"]
}

resource "yandex_vpc_security_group" "kittygram_sg" {
  name       = "kittygram-security-group"
  network_id = yandex_vpc_network.kittygram_network.id

  egress {
    protocol       = "ANY"
    description    = "Allow all outbound traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTP gateway"
    port           = var.gateway_port
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_storage_bucket" "kittygram" {
  bucket    = "kittygram-${replace(var.folder_id, "-", "")}"
  folder_id = var.folder_id
}

resource "yandex_compute_instance" "kittygram_vm" {
  name        = "kittygram-vm"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores  = var.vm_cores
    memory = var.vm_memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.vm_disk_size
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.kittygram_subnet.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.kittygram_sg.id]
  }

  metadata = {
    user-data = <<-EOF
      #cloud-config
      users:
        - name: ${var.vm_user}
          groups: sudo
          shell: /bin/bash
          sudo: 'ALL=(ALL) NOPASSWD:ALL'
          ssh_authorized_keys:
            - ${var.ssh_public_key}
      package_update: true
      packages:
        - docker.io
      runcmd:
        - systemctl enable docker
        - systemctl start docker
        - usermod -aG docker ${var.vm_user}
    EOF
  }
}
