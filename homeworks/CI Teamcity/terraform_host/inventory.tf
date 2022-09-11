resource "local_file" "inventory" {
  content = <<-DOC
---
all:
  hosts:
    nexus-01:
      ansible_host: ${module.nexus.external-ip}
  children:
    nexus:
      hosts:
        nexus-01:
  vars:
    ansible_connection_type: paramiko
    ansible_user: centos

DOC
  filename = "../infrastructure/inventory/cicd/hosts.yml"

  depends_on = [
    module.nexus
  ]
}
