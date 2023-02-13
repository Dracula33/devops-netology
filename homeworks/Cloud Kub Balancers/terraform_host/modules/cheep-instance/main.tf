variable instance_name { default = "" }
variable family { default = "centos-7" }
variable subnet_id { default = "" }
variable cores { default = 2 }
variable memory { default = 4 }
variable core_fraction { default = 20 }
variable disk_size { default = 10 }
variable local_ip { default = "" }
variable need_nat { default = true }

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

data "yandex_compute_image" "default" {
  family = var.family
}

resource "yandex_compute_instance" "instance" {

  name                      = "${var.instance_name}"
  description               = "Дешевая и слабая нода"
  zone                      = "ru-central1-a"
  hostname                  = "${var.instance_name}"
  allow_stopping_for_update = true

  platform_id = "standard-v3"

  scheduling_policy {
    preemptible = true
  }

  resources {
    cores  = "${var.cores}"
    memory = "${var.memory}"
    core_fraction = "${var.core_fraction}"
  }

  boot_disk {
    initialize_params {
      image_id    = data.yandex_compute_image.default.id
      size = "${var.disk_size}"
    }
  }

  network_interface {
    subnet_id  = "${var.subnet_id}"
    ip_address = "${var.local_ip}"
    nat        = "${var.need_nat}"
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
}

output "external-ip" {
  value = "${yandex_compute_instance.instance.network_interface.0.nat_ip_address}" 
}

output "local-ip" {
  value = "${yandex_compute_instance.instance.network_interface.0.ip_address}"
}


