provider "aws" {
  version = "2.70.0"
}

provider "null" {
  version = "3.0.0"
}

terraform {
  required_version = ">= 0.12.9"
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

  count             = length(var.multiple_ec2_vm_complex_data)
  ami               = data.aws_ami.amazon_linux_ami.id
  instance_type     = var.multiple_ec2_vm_complex_data[count.index].instance_type

  tags = merge(
          {"Name":"${local.ec2_instance_name}_${var.multiple_ec2_vm_complex_data[count.index].name}"},
          var.multiple_ec2_vm_complex_data[count.index].tags
         )
}

################################################
######### Dynamic Attributes ###################
################################################

resource "aws_dynamodb_table" "dynamodb_table" {
  name           = "${var.env}_${var.dynamodb.name}"
  billing_mode   = var.dynamodb.billing_mode
  read_capacity  = var.dynamodb.read_capacity
  write_capacity = var.dynamodb.write_capacity
  hash_key       = var.dynamodb.hash_key
  range_key      = var.dynamodb.range_key

  dynamic "attribute" {
    for_each = var.dynamodb.attributes
    content {
      name = attribute.value["name"]
      type = attribute.value["type"]
    }
  }

  tags = var.dynamodb.tags
}

resource "null_resource" "command_trigger_by_dynamodb" {

  triggers = {
    dynamodb_changed = aws_dynamodb_table.dynamodb_table.id
  }

  provisioner "local-exec" {
    command = "echo 'A New DynamoDB Born, you can run an Ansible command' > output_dynamodb_trigger.txt"
  }
}

################################################
######### SNS TOPIC          ###################
################################################

resource "aws_sns_topic" "sns_one" {
  depends_on = [
    aws_instance.single_vm
  ]

  name = "${var.env}-terraform-sns-base"
  delivery_policy = file("policy/sns/sns_${var.env}.json") #only static files, for dynamic use local_file
}

################################################
######### SQS QUEUE          ###################
################################################

resource "aws_sqs_queue" "terraform_queue" {
  depends_on = [
    aws_instance.single_vm
  ]

  name                      = "${var.env}-terraform-queue-base"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  tags = {
    Environment = var.env
  }

  #https://www.terraform.io/docs/provisioners/local-exec.html
  provisioner "local-exec" {
    command = "echo ${aws_sqs_queue.terraform_queue.arn} > output_queue_arn.txt"
  }
}
