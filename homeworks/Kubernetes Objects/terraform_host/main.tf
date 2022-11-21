
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

resource "yandex_container_registry" "my-reg" {
  name = "my-registry"
}

resource "yandex_vpc_subnet" "default" {
  name = "subnet"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["192.168.101.0/24"]
}


module "node1" {
  source = "./modules/cheep-instance"
  instance_name = "node1"
  cores = 4
  memory = 8
  disk_size = 20
  family = "ubuntu-2004-lts"
  subnet_id = "${yandex_vpc_subnet.default.id}"
}

output "external_ip_address_node1" {
  value = "${module.node1.external-ip}"
}

output "registry_id_my_reg" {
  value = "${yandex_container_registry.my-reg.id}"
}
