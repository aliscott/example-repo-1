variable "tags" {
  type = map(string)
}

variable "disk_size" {
  type = number
}

variable "disk_type" {
  type = string
}

variable "s3_versioning_enabled" {
  type    = bool
  default = true
}

resource "aws_ebs_volume" "backups" {
  availability_zone = "us-east-2a" # Always backup to us-east-2
  size              = var.disk_size
  type              = var.disk_type
  tags              = var.tags
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "backups"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = var.s3_versioning_enabled
  }
}
