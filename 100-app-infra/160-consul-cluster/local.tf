locals {
  name   = "consul-${terraform.workspace}"
  bucket = "red-devops-terraform-state"

  tags = {
    Name        = local.name
    Create      = "terraform"
    Environment = terraform.workspace
    function    = "consul-server"
    Team        = var.team
  }

}