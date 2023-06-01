variable "name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "subnet_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.1.0"

  name = var.name

  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = var.subnet_id
  monitoring             = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
