variable "region" {
  description = "Region where to build infrastructure"
  type        = string
}

variable "team" {
  description = "Name of the team"
  type        = string
}

variable "ami_mapping" {
  description = "AMI mapping based on workspace"
  type        = map(string)
  default = {
    dev = "ami-0515eb9fe6701d598"
    uat = "ami-06aa9ad211aebe4c8"
  }
}