resource "local_file" "inventory" {
  content = <<-DOC
---
all:
  hosts:
    redis-01:
      ansible_host: ${module.redis1.external-ip}
    redis-02:
      ansible_host: ${module.redis2.external-ip}
    redis-03:
      ansible_host: ${module.redis3.external-ip}
  children:
    redis:
      hosts:
        redis-01:
        redis-02:
        redis-03:
  vars:
    ansible_connection_type: paramiko
    ansible_user: cloud-user

DOC
  filename = "../ansible/hosts.yml"

  depends_on = [
    module.redis1,
    module.redis2,
    module.redis3
  ]
}
