variable "name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "single_nat_gateway" {
  type    = bool
  default = false
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = var.name
  cidr = "10.0.0.0/16"

  azs             = data.aws_availability_zones.available.names
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  single_nat_gateway = var.single_nat_gateway

  tags = var.tags
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
