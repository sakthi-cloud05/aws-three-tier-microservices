output "alb_dns_name" {
  description = "The public DNS name of the application load balancer"
  value       = aws_lb.external_alb.dns_name
}
