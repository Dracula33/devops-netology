resource "yandex_mdb_mysql_database" "netology_db" {
  cluster_id = yandex_mdb_mysql_cluster.my-mysql-cluster.id
  name       = "netology_db"
}
