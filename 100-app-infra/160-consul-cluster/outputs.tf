output "consul_private_ip" {
  description = "The private IP of consul host"
  value       = aws_instance.consul_server[0].private_ip
}
