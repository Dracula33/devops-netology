resource "yandex_mdb_mysql_cluster" "my-mysql-cluster" {
  name        = "my-mysql-cluster"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.default.id
  version     = "8.0"

  resources {
    resource_preset_id = "b1.medium"
    disk_type_id       = "network-hdd"
    disk_size          = 20
  }

  backup_window_start {
    hours = "23"
    minutes = "59"
  }

  maintenance_window {
    type = "ANYTIME"
  }

  deletion_protection = true

  host {
    zone = "ru-central1-a"
    name      = "db-m-1"
    subnet_id = yandex_vpc_subnet.private-a.id
  }

  host {
    zone = "ru-central1-b"
    name      = "db-m-2"
    subnet_id = yandex_vpc_subnet.private-b.id
  }

  host {
    zone = "ru-central1-b"
    name                    = "db-s-1"
    replication_source_name = "db-m-1"
    subnet_id               = yandex_vpc_subnet.private-b.id
  }

  host {
    zone = "ru-central1-a"
    name                    = "db-s-2"
    replication_source_name = "db-m-2"
    subnet_id               = yandex_vpc_subnet.private-a.id
  }

}
