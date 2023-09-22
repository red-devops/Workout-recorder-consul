locals {
  name   = "rds-data-base-${terraform.workspace}"
  bucket = "red-devops-terraform-state"

  db_name                     = "workoutrecorder"
  db_table_name               = "workout"
  db_admin_username           = "admin"
  db_workoutrecorder_username = "WORKOUT"
  port                        = 3306

  db_admin_secret_path           = "workoutrecorder/db_admin"
  db_workoutrecorder_secret_path = "workoutrecorder/db_workoutrecorder"

  lambda_function_name = "workoutrecorder-data-base-setup-${terraform.workspace}"

  tags = {
    Name        = local.name
    Environment = terraform.workspace
    Create      = "terraform"
    Team        = var.team
  }
}
