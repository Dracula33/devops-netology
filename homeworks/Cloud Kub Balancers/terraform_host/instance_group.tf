resource "yandex_iam_service_account" "instance-group-account" {
  name      = "instance-group-account"
}

resource "yandex_resourcemanager_folder_iam_member" "instance-group-editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.instance-group-account.id}"
}

resource "yandex_compute_instance_group" "test-group" {
  name                = "test-group"

  folder_id = var.folder_id
  service_account_id = yandex_iam_service_account.instance-group-account.id

  instance_template {
      platform_id = "standard-v3"

    scheduling_policy {
      preemptible = true
    }

    resources {
      cores  = 2
      memory = 4
      core_fraction = 20
    }

    boot_disk {
      initialize_params {
        image_id    = "fd827b91d99psvq5fjit"
        size = 10
      }
    }

    network_interface {
      subnet_ids  = [ "${yandex_vpc_subnet.public.id}" ]
      nat        = false
    }

    metadata = {
      ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
      user-data = "${file("cloud-init.yaml")}"
    }

  }

  scale_policy {
    fixed_scale {
      size = 2
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 1
    max_deleting = 2
    max_creating = 2
    max_expansion   = 1
  }

  health_check {
    interval = 30
    timeout = 5
    healthy_threshold = 3
    unhealthy_threshold = 2
    http_options {
      port = 80
      path = "/"
    }
  }

#  load_balancer {
#    target_group_name = "nlb-test-group"
#    target_group_description = "Instances group for network load balancer"
#    max_opening_traffic_duration = 10
#  }

  application_load_balancer {
    target_group_name = "alb-test-group"
    target_group_description = "Instances group for application load balancer"
    max_opening_traffic_duration = 10
  }

  depends_on = [
    yandex_resourcemanager_folder_iam_member.instance-group-editor,
    yandex_vpc_subnet.public
  ]

}
