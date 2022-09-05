resource "local_file" "inventory" {
  content = <<-DOC
---
all:
  hosts:
    jenkins-master-01:
      ansible_host: ${module.j-master.external-ip}
    jenkins-agent-01:
      ansible_host: ${module.j-agent.external-ip}
  children:
    jenkins:
      children:
        jenkins_masters:
          hosts:
            jenkins-master-01:
        jenkins_agents:
          hosts:
            jenkins-agent-01:
  vars:
    ansible_connection_type: paramiko
    ansible_user: centos

DOC
  filename = "../infrastructure/inventory/cicd/hosts.yml"

  depends_on = [
    module.j-master,
    module.j-agent
  ]
}
