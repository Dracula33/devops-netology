resource "local_file" "inventory" {
  content = <<-DOC
---
all:
  hosts:
    minikube-01:
      ansible_host: ${module.minikube.external-ip}
  children:
    minikube:
      hosts:
        minikube-01:
  vars:
    ansible_connection_type: paramiko
    ansible_user: ubuntu

DOC
  filename = "../ansible/hosts.yml"

  depends_on = [
    module.minikube
  ]
}
