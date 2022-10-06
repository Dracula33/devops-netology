resource "yandex_kubernetes_node_group" "node_group" {
  cluster_id = yandex_kubernetes_cluster.cluster.id
  name = "node-group"
  description = "Группа узлов для тестового кластера"

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
      subnet_ids = [ yandex_vpc_subnet.default.id ]
      nat = true
    }

    metadata = {
      ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
    }
  }

  scale_policy {
    auto_scale {
      min = 1
      max = 2
      initial = 1
    }
  }
}

