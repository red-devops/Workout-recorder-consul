locals {
  name   = "vault-${terraform.workspace}"
  bucket = "red-devops-terraform-state"

  tags = {
    Name        = local.name
    Create      = "terraform"
    Environment = terraform.workspace
    Team        = var.team
  }
}
