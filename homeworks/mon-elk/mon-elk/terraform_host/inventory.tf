resource "local_file" "inventory" {
  content = <<-DOC
---
all:
  hosts:
    elk-01:
      ansible_host: ${module.elk.external-ip}
  children:
    elk:
      hosts:
        elk-01:
  vars:
    ansible_connection_type: paramiko
    ansible_user: centos

DOC
  filename = "../ansible/hosts.yml"

  depends_on = [
    module.elk
  ]
}
