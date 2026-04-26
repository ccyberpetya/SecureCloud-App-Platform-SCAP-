resource "yandex_vpc_network" "scap_vpc" {
  name = var.yandex_vpc

}

resource "yandex_vpc_subnet" "scap_vpc" {
  name           = "${var.yandex_vpc}-subnet"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.scap_vpc.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_security_group" "scap_sg" {
  name       = "scap-security-group"
  network_id = yandex_vpc_network.scap_vpc.id

  ingress {
    description    = "SSH"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = var.allowed_ssh_cidrs
  }

  ingress {
    description    = "HTTP app"
    protocol       = "TCP"
    port           = 8000
    v4_cidr_blocks = var.allowed_http_app_cidrs
  }

  egress {
    description    = "Allow all outbound traffic"
    protocol       = "ANY"
    v4_cidr_blocks = var.allowed_outbound_cidrs
  }
}

data "yandex_compute_image" "ubuntu" {
  family = var.app_image_family
}

resource "yandex_compute_instance" "app" {
  name                      = var.app_name
  platform_id               = var.app_platform_id
  allow_stopping_for_update = true


  resources {
    cores         = var.app_resources.cores
    memory        = var.app_resources.memory
    core_fraction = var.app_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.app_resources.hdd_size
      type     = var.app_resources.hdd_type

    }
  }
  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.scap_vpc.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.scap_sg.id]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${file(var.ssh_public_key_path)}"
  }
}

resource "yandex_compute_instance" "monitoring" {
  name                      = var.monitoring_name
  platform_id               = var.monitoring_platform_id
  allow_stopping_for_update = true


  resources {
    cores         = var.monitoring_resources.cores
    memory        = var.monitoring_resources.memory
    core_fraction = var.monitoring_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.monitoring_resources.hdd_size
      type     = var.monitoring_resources.hdd_type

    }
  }
  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.scap_vpc.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.scap_sg.id]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${file(var.ssh_public_key_path)}"
  }
}


