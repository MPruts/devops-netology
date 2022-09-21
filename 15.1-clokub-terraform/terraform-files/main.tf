terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone      = "ru-central1-b"
}

resource "yandex_compute_instance" "netology-pc-1" {
  name = "pc-1-netology"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public-subnet-1.id
    ip_address = "192.168.10.254"
    nat = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}


resource "yandex_compute_instance" "netology-pc-2" {
  name = "pc-2-netology"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8c00efhiopj3rlnlbn"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public-subnet-1.id
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}


resource "yandex_compute_instance" "netology-pc-3" {
  name = "pc-3-netology"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8c00efhiopj3rlnlbn"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private-subnet-2.id
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
//_______________________________________________________________________________________

resource "yandex_vpc_network" "net-1-netology" {
  name = "netology-net-1"
}

resource "yandex_vpc_subnet" "public-subnet-1" {
  name           = "public"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.net-1-netology.id
  v4_cidr_blocks = ["192.168.10.0/24"]
  route_table_id = yandex_vpc_route_table.netology-rt-1.id
}

resource "yandex_vpc_subnet" "private-subnet-2" {
  name           = "private"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.net-1-netology.id
  v4_cidr_blocks = ["192.168.20.0/24"]
  route_table_id = yandex_vpc_route_table.netology-rt-2.id
}

resource "yandex_vpc_route_table" "netology-rt-1" {
  network_id = "${yandex_vpc_network.net-1-netology.id}"
  name = "rt-netology-1"

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.10.254"
  }
}

resource "yandex_vpc_route_table" "netology-rt-2" {
  network_id = "${yandex_vpc_network.net-1-netology.id}"
  name = "rt-netology-2"

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.10.254"
  }
}

output "internal_ip_address_netology_pc_1" {
  value = yandex_compute_instance.netology-pc-1.network_interface.0.ip_address
}

output "external_ip_address_netology_pc_1" {
  value = yandex_compute_instance.netology-pc-1.network_interface.0.nat_ip_address
}

output "internal_ip_address_netology_pc_2" {
  value = yandex_compute_instance.netology-pc-2.network_interface.0.ip_address
}

output "internal_ip_address_netology_pc_3" {
  value = yandex_compute_instance.netology-pc-3.network_interface.0.ip_address
}