
resource "yandex_vpc_network" "default" {
  name = "net"
}

resource "yandex_vpc_subnet" "public" {
  name = "public"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["192.168.10.0/24"]
}
