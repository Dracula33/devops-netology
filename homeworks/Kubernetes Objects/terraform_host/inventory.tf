resource "local_file" "inventory" {
  content = <<-DOC
---
all:
  hosts:
    node1:
      ansible_host: ${module.node1.external-ip}
  children:
    kube_control_plane:
      hosts:
        node1:
    etcd:
      hosts:
        node1:
    kube_node:
      hosts:
        node1:
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
  vars:
    ansible_connection_type: paramiko
    ansible_user: ubuntu

DOC
  filename = "../ansible/hosts.yml"

  depends_on = [
    module.node1
  ]
}
