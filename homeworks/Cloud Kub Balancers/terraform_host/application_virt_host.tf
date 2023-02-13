
resource "yandex_alb_virtual_host" "alb-virtual-host" {
  name      = "test-virtual-host"
  http_router_id = yandex_alb_http_router.alb-http-router.id
  route {
    name = "my-picture"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.alb-backend-group.id
        timeout = "3s"
      }
    }
  }
}
