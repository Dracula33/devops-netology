output "kuber_cluster_id" {
  value = "${yandex_kubernetes_cluster.cluster.id}"
}

output "kuber_cluster_ip" {
  value = "${yandex_kubernetes_cluster.cluster.master[0].external_v4_address}"
}

output "container_registry_id" {
  value = yandex_container_registry.my-reg.id
}

