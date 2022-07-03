
variable platform_id { default = "standard-v3" }
variable subnet_id { default = "" }

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

data "yandex_compute_image" "default" {
  family = "centos-7"
}

resource "yandex_compute_instance" "instance" {

  name                      = "test-instance"
  description               = "Дешевая и слабая нода centos7"
  zone                      = "ru-central1-a"
  hostname                  = "test-instance"
  allow_stopping_for_update = true

  platform_id = var.platform_id

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
      image_id    = data.yandex_compute_image.default.id
      size = "10"
    }
  }

  network_interface {
    subnet_id  = "${var.subnet_id}"
    nat        = true
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
}

output "external-ip" {
  value = "${yandex_compute_instance.instance.network_interface.0.nat_ip_address}" 
}


