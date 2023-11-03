output "nlb_dns_name" {
  description = "The DNS name of the Network Load Balancer"
  value       = aws_lb.NLB1.dns_name
}