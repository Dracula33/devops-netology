resource "yandex_kubernetes_node_group" "my-kuber-cluster-node-group" {
  cluster_id = yandex_kubernetes_cluster.my-kuber-cluster.id
  name = "my-kuber-cluster-node-group"
  description = "Группа узлов для тестового кластера"

  allocation_policy {
    location {
      zone      = "ru-central1-a"
    }
  }

  instance_template {
    platform_id = "standard-v1"

    boot_disk {
      size = 30
    }

    resources {
      core_fraction = 20
      cores = 2
      memory = 4
    }

    scheduling_policy {
      preemptible = true
    }

    network_interface {
      subnet_ids = [
        yandex_vpc_subnet.public-a.id
      ]
      nat = true
    }

    metadata = {
      ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
    }
  }

  scale_policy {
    auto_scale {
      min = 1
      max = 6
      initial = 1
    }
  }

}

