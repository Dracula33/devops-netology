variable instance_name { default = "" }
variable subnet_id { default = "" }
variable cores { default = 2}
variable memory { default = 4}
variable docker_image_url { default = "" }
variable container_envs { default = "" }

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

data "yandex_compute_image" "default" {
  family = "container-optimized-image"
}

resource "yandex_compute_instance" "instance" {

  name                      = "${var.instance_name}"
  description               = "Контейнер нода"
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
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id    = data.yandex_compute_image.default.id
      size = "30"
    }
  }

  network_interface {
    subnet_id  = "${var.subnet_id}"
    nat        = true
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
    docker-container-declaration = <<-DOC
---
spec:
  containers:
  - image: ${var.docker_image_url}
    env:
    ${var.container_envs}
    securityContext:
      privileged: false
    stdin: false
    tty: false
DOC

  }
}

output "external-ip" {
  value = "${yandex_compute_instance.instance.network_interface.0.nat_ip_address}" 
}


