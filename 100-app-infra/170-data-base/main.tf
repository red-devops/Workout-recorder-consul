resource "random_password" "db_admin_password" {
  length  = 16
  special = false
}
resource "vault_generic_secret" "db_admin_secret" {
  path      = "kv/${local.db_admin_secret_path}"
  data_json = <<EOT
    {
      "username": "${local.db_admin_username}",
      "password": "${random_password.db_admin_password.result}"
    }
  EOT
}

resource "random_password" "db_workoutrecorder_password" {
  length  = 8
  special = false
}
resource "vault_generic_secret" "db_workoutrecorder_secret" {
  path      = "kv/${local.db_workoutrecorder_secret_path}"
  data_json = <<EOT
    {
      "username": "${local.db_workoutrecorder_username}",
      "password": "${random_password.db_workoutrecorder_password.result}"
    }
  EOT
}

module "db" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-rds.git"

  identifier           = lower("${local.name}")
  engine               = "mysql"
  engine_version       = "8.0"
  family               = "mysql8.0"
  major_engine_version = "8.0"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20

  port                        = local.port
  db_name                     = local.db_name
  username                    = vault_generic_secret.db_admin_secret.data["username"]
  password                    = vault_generic_secret.db_admin_secret.data["password"]
  manage_master_user_password = false

  create_db_option_group    = false
  create_db_parameter_group = false
  apply_immediately         = true
  skip_final_snapshot       = true

  multi_az             = false
  db_subnet_group_name = data.terraform_remote_state.network.outputs.database_subnet_group

  vpc_security_group_ids = [
    data.terraform_remote_state.security_group.outputs.db_sg_id
  ]

  tags = local.tags
}

resource "consul_keys" "database_endpoint" {
  key {
    path  = "config/workoutrecorder/database-endpoint"
    value = module.db.db_instance_endpoint
  }
}
