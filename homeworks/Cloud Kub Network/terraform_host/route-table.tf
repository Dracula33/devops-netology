
resource "yandex_vpc_route_table" "for-private" {
  name = "for-private"
  network_id = "${yandex_vpc_network.default.id}"

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address = "${module.nat-instance.local-ip}"
  }
}
