module "backend_asg" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-autoscaling.git"
  name   = "${local.name}-backend-ASG"

  vpc_zone_identifier = data.terraform_remote_state.network.outputs.private_subnets
  min_size            = 0
  max_size            = 1
  desired_capacity    = 1
  key_name            = "app_${terraform.workspace}_key"

  image_id        = data.aws_ami.ubuntu.id
  instance_type   = "t3.micro"
  security_groups = [data.terraform_remote_state.security_group.outputs.backend_ec2_sg_id]

  iam_instance_profile_arn = aws_iam_instance_profile.describe_instances_profile.arn

  tags = merge(local.tags, {
    ostype = "linux"
  })
}

module "frontend_asg" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-autoscaling.git"
  name   = "${local.name}-frontend-ASG"

  vpc_zone_identifier = data.terraform_remote_state.network.outputs.private_subnets
  min_size            = 0
  max_size            = 1
  desired_capacity    = 1
  key_name            = "app_${terraform.workspace}_key"

  image_id        = data.aws_ami.ubuntu.id
  instance_type   = "t3.micro"
  security_groups = [data.terraform_remote_state.security_group.outputs.frontend_ec2_sg_id]

  iam_instance_profile_arn = aws_iam_instance_profile.describe_instances_profile.arn

  tags = merge(local.tags, {
    ostype = "linux"
  })
}

resource "aws_instance" "fabio" {
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = "t3.micro"
  subnet_id            = data.terraform_remote_state.network.outputs.public_subnets[0]
  iam_instance_profile = aws_iam_instance_profile.describe_instances_profile.id
  key_name             = "app_${terraform.workspace}_key"

  associate_public_ip_address = true
  vpc_security_group_ids = [
    data.terraform_remote_state.security_group.outputs.fabio_ec2_sg_id
  ]

  user_data = templatefile(
    "${path.root}/templates/user-data.sh",
    {
      env = "${terraform.workspace}"
    }
  )

  tags = merge(local.tags, {
    ostype = "linux",
    Name   = "fabio-${terraform.workspace}"
  })
}
