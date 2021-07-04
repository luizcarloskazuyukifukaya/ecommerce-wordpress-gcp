resource "kubernetes_service" "lb" {
  metadata {
    name = "wordpress"
  }
  spec {
    selector = {
      
      App = "frontend"
      
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  } 
}

output "wordpress_lb_ip" {
  value = kubernetes_service.lb.status.0.load_balancer.0.ingress.0.ip
}

output "wordpress_lb_hostname" {
  value = kubernetes_service.lb.status.0.load_balancer.0.ingress.0.hostname
}