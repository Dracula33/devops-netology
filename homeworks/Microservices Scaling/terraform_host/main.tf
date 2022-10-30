
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


module "redis1" {
  source = "./modules/cheep-instance"
  instance_name = "redis1"
  family = "centos-8"
  subnet_id = "${yandex_vpc_subnet.default.id}"
}

module "redis2" {
  source = "./modules/cheep-instance"
  instance_name = "redis2"
  family = "centos-8"
  subnet_id = "${yandex_vpc_subnet.default.id}"
}

module "redis3" {
  source = "./modules/cheep-instance"
  instance_name = "redis3"
  family = "centos-8"
  subnet_id = "${yandex_vpc_subnet.default.id}"
}

output "external_ip_address_redis1" {
  value = "${module.redis1.external-ip}"
}

output "external_ip_address_redis2" {
  value = "${module.redis2.external-ip}"
}

output "external_ip_address_redis3" {
  value = "${module.redis3.external-ip}"
}
