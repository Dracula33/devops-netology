
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


module "j-master" {
  source = "./modules/cheep-instance"
  instance_name = "j-master"
  family = "centos-7"
  subnet_id = "${yandex_vpc_subnet.default.id}"
}

module "j-agent" {
  source = "./modules/cheep-instance"
  instance_name = "j-agent"
  family = "centos-7"
  subnet_id = "${yandex_vpc_subnet.default.id}"
}

output "external_ip_address_j-master" {
  value = "${module.j-master.external-ip}"
}

output "external_ip_address_j-agent" {
  value = "${module.j-agent.external-ip}"
}

