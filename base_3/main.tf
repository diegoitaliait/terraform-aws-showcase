provider "aws" {
  version = "2.70.0"
}

################################################
######### Multiple Resources ###################
################################################

data "aws_ami" "amazon_linux_ami" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

# RESOURCES

resource "aws_instance" "single_vm" {
  ami             = data.aws_ami.amazon_linux_ami.id
  instance_type   = var.instance_type

  tags = var.single_vm_tags
}

resource "aws_instance" "multiple_vm_simple" {

  count             = length(var.multiple_ec2_vm_simple)
  ami               = data.aws_ami.amazon_linux_ami.id
  instance_type     = var.instance_type

  tags = {
    Name        = "${local.ec2_instance_name}_${var.multiple_ec2_vm_simple[count.index]}"
    Environment = var.env
    os          = var.os
  }
}

resource "aws_instance" "multiple_ec2_vm_complex" {

  count             = length(var.multiple_ec2_vm_with_validation)
  ami               = data.aws_ami.amazon_linux_ami.id
  instance_type     = var.multiple_ec2_vm_with_validation[count.index].instance_type

  tags = merge(
          {"Name":"${local.ec2_instance_name}_${var.multiple_ec2_vm_with_validation[count.index].name}"},
          var.multiple_ec2_vm_with_validation[count.index].tags
         )
}

################################################
######### Dynamic Attributes ###################
################################################

# resource "aws_dynamodb_table" "dynamodb_table" {
#   name           = local.dynamodb_table_name
#   billing_mode   = var.table_billing_mode
#   read_capacity  = var.table_read_capacity
#   write_capacity = var.table_write_capacity
#   hash_key       = var.table_hash_key
#   range_key      = var.table_range_key

#   dynamic "attribute" {
#     for_each = var.table_indexed_attributes
#     content {
#       name = attribute.value["name"]
#       type = attribute.value["type"]
#     }
#   }

#   # ttl = var.ttl
#   dynamic "ttl" {
#     for_each = var.ttl
#     content {
#       attribute_name  = ttl.value["attribute_name"]
#       enabled         = ttl.value["enabled"]
#     }
#   }

#   tags = var.tags
# }

################################################
######### xxxxxxxxxxxxxxxxxx ###################
################################################

resource "aws_sqs_queue" "terraform_queue" {
  name                      = "terraform-queue-base-${var.env}"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  tags = {
    Environment = var.env
  }
}
