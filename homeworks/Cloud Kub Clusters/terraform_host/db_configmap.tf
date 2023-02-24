resource "local_file" "db-conf" {
  content = <<-DOC
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: dbconf
data:
  mysql_host: "${yandex_mdb_mysql_cluster.my-mysql-cluster.host[0].fqdn}"
  mysql_port: "3306"
  mysql_dbname: "${yandex_mdb_mysql_database.netology_db.name}"
  mysql_user: "${yandex_mdb_mysql_user.test-user.name}"
  mysql_user_pass: "${yandex_mdb_mysql_user.test-user.password}"
DOC
  filename = "../manifest/configmap.yaml"
}

