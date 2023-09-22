resource "aws_security_group" "frontend_ec2" {
  name        = "${local.name}-frontend-ec2"
  description = "Frontend EC2 security group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress = [
    local.allow_ssh,
    local.allow_http,
    local.allow_8300,
    local.allow_8301
  ]

  egress = [
    local.allow_http,
    local.allow_https,
    local.allow_8080,
    local.allow_8300,
    local.allow_8301,
    local.allow_8301_udp
  ]

  tags = merge(local.tags, {
    Name = "${local.name}-frontend-ec2"
  })
}

resource "aws_security_group" "backend_ec2" {
  name        = "${local.name}-backend-ec2"
  description = "Backend EC2 security group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress = [
    local.allow_ssh,
    local.allow_8080,
    local.allow_8300,
    local.allow_8301
  ]

  egress = [
    local.allow_http,
    local.allow_https,
    merge(
      local.allow_mysql,
      { security_groups = [aws_security_group.db.id] }
    ),
    local.allow_8300,
    local.allow_8301,
    local.allow_8301_udp
  ]

  tags = merge(local.tags, {
    Name = "${local.name}-backend-ec2"
  })
}

resource "aws_security_group" "cicd_agent" {
  name        = "${local.name}-cicd-agent"
  description = "CICD agent security group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  egress = [
    local.allow_ssh,
    local.allow_https,
    local.allow_8200,
    local.allow_8500
  ]

  tags = local.tags
}

resource "aws_security_group" "db" {
  name        = "${local.name}-db"
  description = "DB security group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id
  tags = merge(local.tags, {
    Name = "${local.name}-db"
  })
}

resource "aws_security_group_rule" "db_ingress" {
  security_group_id = aws_security_group.db.id
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = [data.terraform_remote_state.network.outputs.vpc_cidr_block]
}

resource "aws_security_group_rule" "db_egress" {
  security_group_id = aws_security_group.db.id
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  type              = "egress"
  cidr_blocks       = [data.terraform_remote_state.network.outputs.vpc_cidr_block]
}

resource "aws_security_group" "vault_ec2" {
  name        = "${local.name}-vault"
  description = "Vault Server security group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress = [
    local.allow_8200,
    local.allow_8201,
    local.allow_ssh
  ]
  egress = [
    local.allow_ssh,
    local.allow_http,
    local.allow_https
  ]

  tags = merge(local.tags, {
    Name = "${local.name}-vault-ec2"
  })
}

resource "aws_security_group" "consul_ec2" {
  name        = "${local.name}-consul"
  description = "Consul server security group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress = [
    local.allow_all,
    local.allow_all_udp
  ]
  egress = [
    local.allow_all,
    local.allow_all_udp
  ]

  tags = merge(local.tags, {
    Name = "${local.name}-consul-ec2"
  })
}

resource "aws_security_group" "lambda" {
  name        = "${local.name}-lambda"
  description = "Lambda security group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  egress = [
    merge(
      local.allow_mysql,
      { cidr_blocks = data.terraform_remote_state.network.outputs.database_subnets_cidr_blocks }
    ),
    local.allow_http,
    local.allow_https,
    local.allow_8200
  ]

  tags = merge(local.tags, { Name = "${local.name}-lambda" })
}

resource "aws_security_group" "fabio" {
  name        = "${local.name}-fabio"
  description = "Fabio security group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress = [
    local.allow_ssh,
    local.allow_9998,
    local.allow_9999,
  ]

  egress = [
    local.allow_http,
    local.allow_https,
    local.allow_8080,
    local.allow_8300,
    local.allow_8301,
    local.allow_8301_udp,
    local.allow_8500
  ]

  tags = merge(local.tags, { Name = "${local.name}-fabio" })
}