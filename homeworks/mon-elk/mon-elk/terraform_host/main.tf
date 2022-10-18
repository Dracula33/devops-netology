
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


module "elk" {
  source = "./modules/cheep-instance"
  instance_name = "elk"
  family = "centos-7"
  memory = 8
  subnet_id = "${yandex_vpc_subnet.default.id}"
}

output "external_ip_address_elk" {
  value = "${module.elk.external-ip}"
}

