resource "local_file" "inventory" {
  content = <<-DOC
---
all:
  hosts:
    monitor-01:
      ansible_host: ${module.monitor.external-ip}
  children:
    monitor:
      hosts:
        monitor-01:
  vars:
    ansible_connection_type: paramiko
    ansible_user: centos

DOC
  filename = "../ansible/hosts.yml"

  depends_on = [
    module.monitor
  ]
}
