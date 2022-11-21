resource "local_file" "registry" {
  content = <<-DOC
${yandex_container_registry.my-reg.id}
DOC
  filename = "../ansible/reg_id.txt"

  depends_on = [
    yandex_container_registry.my-reg
  ]
}
