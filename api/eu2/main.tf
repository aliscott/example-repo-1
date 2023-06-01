variable "region" {
  type = string
}

variable "api_instance_type" {
  type = string
}

variable "tags" {
  type = map(string)
}

provider "aws" {
  region = var.region
}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["vpc"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

  tags = {
    Tier = "Public"
  }
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.selected.id

  filter {
    name   = "group-name"
    values = ["default"]
  }
}

module "api_instance" {
  source = "../../modules/ec2"

  name                   = "api"
  instance_type          = var.api_instance_type
  key_name               = "terraform"
  vpc_security_group_ids = [data.aws_security_group.default.id]
  subnet_id              = data.aws_subnets.public.ids[0]

  tags = var.tags
}
