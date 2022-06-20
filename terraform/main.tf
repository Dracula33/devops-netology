provider "yandex" {
  zone = "ru-central1-a"
}

resource "yandex_compute_instance" "test-vm" {
  name                      = "test-vm"
  description               = "Тестовая виртуалка для HW 7.2"
  hostname                  = "test-vm.netology.yc"
  allow_stopping_for_update = true

  platform_id = "standard-v3"

  scheduling_policy {
    preemptible = true
  }

  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id    = "fd80le4b8gt2u33lvubr" //centos-7-v20211220
      name        = "test-vm-disk"
      type        = "network-nvme"
      size        = "10"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.test-subnet.id}"
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
}


resource "yandex_vpc_network" "test-net" {}

resource "yandex_vpc_subnet" "test-subnet" {
  network_id = "${yandex_vpc_network.test-net.id}"
  v4_cidr_blocks = ["192.168.128.0/24"]
}

output "instance_private_ip" {
  value = "${yandex_compute_instance.test-vm.network_interface[0].ip_address}"
  description = "Ip address of test virtual machine"
}

output "subnetwork_id" {
  description = "Cerrent subnetwork-id"
  value = "${yandex_vpc_subnet.test-subnet.id}"
}

output "current_zone" {
  description = "Current zone for instance"
  value = "${yandex_compute_instance.test-vm.zone}"
}
