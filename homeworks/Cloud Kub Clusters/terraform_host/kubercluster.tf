resource "yandex_kubernetes_cluster" "my-kuber-cluster" {
  network_id = yandex_vpc_network.default.id
  name = "my-kuber-cluster"
  description = "тестовый кластер"

  service_account_id      = yandex_iam_service_account.kuber-account.id
  node_service_account_id = yandex_iam_service_account.kuber-account.id

  master {

    version = "1.22"
    public_ip = true

    regional {
      region = "ru-central1"

      location {
        zone      = yandex_vpc_subnet.public-a.zone
        subnet_id = yandex_vpc_subnet.public-a.id
      }

      location {
        zone      = yandex_vpc_subnet.public-b.zone
        subnet_id = yandex_vpc_subnet.public-b.id
      }

      location {
        zone      = yandex_vpc_subnet.public-c.zone
        subnet_id = yandex_vpc_subnet.public-c.id
      }
    }
  }

  kms_provider {
    key_id = yandex_kms_symmetric_key.my-symmetric-key.id
  }

  depends_on = [
    yandex_resourcemanager_folder_iam_member.editor,
    yandex_resourcemanager_folder_iam_member.image-puller
  ]
}

output "cluster_id" {
  value = yandex_kubernetes_cluster.my-kuber-cluster.id
}