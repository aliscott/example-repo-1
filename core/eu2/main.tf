variable "region" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "single_nat_gateway" {
  type    = bool
  default = false
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../../modules/vpc"

  name               = "vpc"
  single_nat_gateway = var.single_nat_gateway
  tags               = var.tags
}
