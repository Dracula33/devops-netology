
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


module "node1" {
  source = "./modules/cheep-instance"
  instance_name = "node1-master"
  family = "ubuntu-2004-lts"
  subnet_id = "${yandex_vpc_subnet.default.id}"
}

module "node2" {
  source = "./modules/cheep-instance"
  instance_name = "node2"
  family = "ubuntu-2004-lts"
  subnet_id = "${yandex_vpc_subnet.default.id}"
}

module "node3" {
  source = "./modules/cheep-instance"
  instance_name = "node3"
  family = "ubuntu-2004-lts"
  subnet_id = "${yandex_vpc_subnet.default.id}"
}

module "node4" {
  source = "./modules/cheep-instance"
  instance_name = "node4"
  family = "ubuntu-2004-lts"
  subnet_id = "${yandex_vpc_subnet.default.id}"
}

module "node5" {
  source = "./modules/cheep-instance"
  instance_name = "node5"
  family = "ubuntu-2004-lts"
  subnet_id = "${yandex_vpc_subnet.default.id}"
}

output "external_ip_address_node1" {
  value = "${module.node1.external-ip}"
}

output "external_ip_address_node2" {
  value = "${module.node2.external-ip}"
}

output "external_ip_address_node3" {
  value = "${module.node3.external-ip}"
}

output "external_ip_address_node4" {
  value = "${module.node4.external-ip}"
}

output "external_ip_address_node5" {
  value = "${module.node5.external-ip}"
}