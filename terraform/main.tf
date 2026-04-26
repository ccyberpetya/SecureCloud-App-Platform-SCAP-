resource "yandex_vpc_network" "scap-vpc" {
    name        = var.yandex_vpc
  
}

resource "yandex_vpc_subnet" "scap-vpc" {
    name            = "${var.yandex_vpc}-subnet"
    zone            = var.default_zone
    network_id      = yandex_vpc_network.scap-vpc.id
    v4_cidr_blocks  = var.default_cidr
}

resource "yandex_vpc_security_group" "scap_sg" {
  name       = "scap-security-group"
  network_id = yandex_vpc_network.scap-vpc.id

  ingress {
    description    = "SSH"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "HTTP app"
    protocol       = "TCP"
    port           = 8000
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description    = "Allow all outbound traffic"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

data "yandex_compute_image" "ubuntu" {
    family          = var.app_image_family
}

resource "yandex_compute_instance" "app" {
    name            = var.app_name
    platform_id     = var.app_platform_id
    allow_stopping_for_update = true


    resources {
        cores           = var.app_resources.cores
        memory          = var.app_resources.memory
        core_fraction   = var.app_resources.core_fraction
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
            subnet_id = yandex_vpc_subnet.scap-vpc.id
            nat = true
            security_group_ids = [yandex_vpc_security_group.scap_sg.id]
    }

    metadata = {
            serial-port-enable = 1
            ssh-keys           =  "ubuntu:${file(var.ssh_public_key_path)}"
     }
    }
  

