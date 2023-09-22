output "vault_private_ip" {
  description = "The private IP of vault host"
  value       = aws_instance.vault_server.private_ip
}