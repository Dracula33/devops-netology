resource "local_file" "inventory" {
  content = <<-DOC
---
all:
  hosts:
    tick-01:
      ansible_host: ${module.tick.external-ip}
  children:
    tick:
      hosts:
        tick-01:
  vars:
    ansible_connection_type: paramiko
    ansible_user: centos

DOC
  filename = "../ansible/hosts.yml"

  depends_on = [
    module.tick
  ]
}
