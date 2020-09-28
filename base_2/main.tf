provider "aws" {
  version = "2.70.0"
}

# DATA

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

resource "aws_instance" "vm" {
  ami           = data.aws_ami.amazon_linux_ami.id
  instance_type = var.instance_type

  tags = {
    Name        = local.ec2_instance_name
    Environment = var.env
    so          = var.os
    my_number   = var.my_number
    my_bool     = var.my_bool
  }
}

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
