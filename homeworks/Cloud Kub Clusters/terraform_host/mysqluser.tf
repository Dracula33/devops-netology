resource "yandex_mdb_mysql_user" "test-user" {
  cluster_id = yandex_mdb_mysql_cluster.my-mysql-cluster.id
  name       = "testuser"
  password   = "testpass"

  permission {
    database_name = "netology_db"
    roles         = ["ALL"]
  }

  global_permissions = ["PROCESS"]

  authentication_plugin = "SHA256_PASSWORD"

  depends_on = [
    yandex_mdb_mysql_database.netology_db
  ]
}
