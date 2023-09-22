output "fabio_public_ip" {
  description = "The public IP of fabio host"
  value       = aws_instance.fabio.public_ip
}
