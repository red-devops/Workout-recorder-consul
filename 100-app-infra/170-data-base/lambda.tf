resource "local_file" "render_python_script" {
  content = templatefile(
    "${path.module}/templates/template_handler.py",
    {
      region            = "${var.region}"
      db_name           = "${local.db_name}",
      db_endpoint       = "${module.db.db_instance_address}"
      environment       = terraform.workspace
      db_admin_username = vault_generic_secret.db_admin_secret.data["username"]
      vault_endpoitn    = "http://${data.terraform_remote_state.vault_instance.outputs.vault_private_ip}:8200"

      db_admin_secret_path           = local.db_admin_secret_path
      db_workoutrecorder_secret_path = local.db_workoutrecorder_secret_path
    }
  )
  filename = "${path.module}/lambda_script/handler.py"

  depends_on = [
    module.db
  ]
}

resource "local_file" "render_db_script" {
  content = templatefile(
    "${path.module}/templates/template_mysql_setup_script.sql",
    {
      db_name                     = local.db_name
      db_table_name               = local.db_table_name
      db_workoutrecorder_username = local.db_workoutrecorder_username
      db_workoutrecorder_password = "${random_password.db_workoutrecorder_password.result}"
    }
  )
  filename = "${path.module}/lambda_script/mysql_setup_script.sql"

  depends_on = [
    module.db
  ]
}

module "lambda_layer_local" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-lambda.git"

  create_layer = true

  layer_name               = "${local.lambda_function_name}-python-layer"
  description              = "Lambda layer for python"
  compatible_runtimes      = ["python3.9"]
  compatible_architectures = ["x86_64"]

  source_path = "${path.module}/lambda_script"
}


module "db_setup_lambda" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-lambda.git"

  function_name = local.lambda_function_name
  description   = "Script for workoutrecorder MySQL DB setup"
  handler       = "handler.setup_db"
  runtime       = "python3.9"
  source_path   = "${path.module}/lambda_script/"
  timeout       = 5

  vpc_subnet_ids = data.terraform_remote_state.network.outputs.private_subnets

  vpc_security_group_ids = [
    data.terraform_remote_state.security_group.outputs.lambda_sg_id
  ]

  attach_network_policy = true
  attach_policy         = true
  policy                = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"

  attach_policies = true
  policies = [
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  ]
  number_of_policies = 1

  layers = [
    "arn:aws:lambda:eu-central-1:187925254637:layer:AWS-Parameters-and-Secrets-Lambda-Extension:4",
    module.lambda_layer_local.lambda_layer_arn
  ]

  tags = local.tags

  depends_on = [
    module.db,
    local_file.render_python_script,
    local_file.render_db_script
  ]
}

resource "null_resource" "invoke_lambda" {
  provisioner "local-exec" {
    command = "aws lambda invoke --function-name ${module.db_setup_lambda.lambda_function_name} --region ${var.region} response.json"
  }
  depends_on = [
    module.db_setup_lambda
  ]
}
