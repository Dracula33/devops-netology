
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
}

resource "yandex_vpc_network" "default" {
  name = "net"
}

resource "yandex_vpc_subnet" "default" {
  name = "subnet"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["192.168.101.0/24"]
}


module "minikube" {
  source = "./modules/cheep-instance"
  instance_name = "minikube"
  family = "ubuntu-2004-lts"
  subnet_id = "${yandex_vpc_subnet.default.id}"
}

output "external_ip_address_minikube" {
  value = "${module.minikube.external-ip}"
}
