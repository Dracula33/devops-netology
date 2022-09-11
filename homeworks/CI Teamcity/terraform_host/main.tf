
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

module "nexus" {
  source = "./modules/cheep-instance"
  instance_name = "nexus"
  subnet_id = "${yandex_vpc_subnet.default.id}"
}

module "teamcity-server" {
  source = "./modules/container-instance"
  instance_name = "teamcity-server"
  docker_image_url = "jetbrains/teamcity-server"
  cores = 4
  subnet_id = "${yandex_vpc_subnet.default.id}"
}

module "teamcity-agent" {
  source = "./modules/container-instance"
  instance_name = "teamcity-agent"
  docker_image_url = "jetbrains/teamcity-agent"
  container_envs = <<-DOC
    - name: SERVER_URL
          value: http://${module.teamcity-server.external-ip}:8111
DOC
  cores = 2
  subnet_id = "${yandex_vpc_subnet.default.id}"
}

output "external_ip_address_nexus" {
  value = "${module.nexus.external-ip}"
}

output "external_ip_address_teamcity-server" {
  value = "${module.teamcity-server.external-ip}"
}

output "external_ip_address_teamcity-agent" {
  value = "${module.teamcity-agent.external-ip}"
}
