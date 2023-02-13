resource "yandex_alb_backend_group" "alb-backend-group" {
  name      = "test-backend-group"

  http_backend {
    name = "my-pic-http-backend"
    weight = 1
    port = 80
    target_group_ids = ["${yandex_compute_instance_group.test-group.application_load_balancer[0].target_group_id}"]
    load_balancing_config {
      panic_threshold = 50
      mode = "ROUND_ROBIN"
    }
    healthcheck {
      timeout = "1s"
      interval = "1s"
      http_healthcheck {
        path  = "/"
      }
    }
  }
}
