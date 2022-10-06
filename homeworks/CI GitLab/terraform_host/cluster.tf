resource "yandex_kubernetes_cluster" "cluster" {
  network_id = yandex_vpc_network.default.id
  name = "test-cluster"
  description = "тестовый кластер"
  master {
    version = "1.22"
    public_ip = true
    zonal {
      zone      = yandex_vpc_subnet.default.zone
      subnet_id = yandex_vpc_subnet.default.id
    }
  }
  service_account_id      = var.service_account_id
  node_service_account_id = var.service_account_id
}

