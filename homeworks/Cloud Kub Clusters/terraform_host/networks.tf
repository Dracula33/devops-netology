
resource "yandex_vpc_network" "default" {
  name = "net"
}

resource "yandex_vpc_subnet" "public-a" {
  name = "public-a"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "public-b" {
  name = "public-b"
  zone           = "ru-central1-b"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["192.168.9.0/24"]
}

resource "yandex_vpc_subnet" "public-c" {
  name = "public-c"
  zone           = "ru-central1-c"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["192.168.8.0/24"]
}

resource "yandex_vpc_subnet" "private-a" {
  name = "private-a"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["192.168.11.0/24"]
}

resource "yandex_vpc_subnet" "private-b" {
  name = "private-b"
  zone           = "ru-central1-b"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["192.168.12.0/24"]
}
