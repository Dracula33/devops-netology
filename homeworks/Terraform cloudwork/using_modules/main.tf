
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  service_account_key_file = "key.json"
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


module "node01" {
  source = "./modules/cheep-centos7-instance"
  subnet_id = "${yandex_vpc_subnet.default.id}"
}

output "external_ip_address_node01" {
  value = "${module.node01.external-ip}"
}
