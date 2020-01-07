provider "aws" {
  version = "2.40.0"
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

resource "aws_instance" "micro_base_test" {
  ami           = data.aws_ami.amazon_linux_ami.id
  instance_type = "t2.micro"

  tags = {
    Name = "micro_base_one"
  }
}

resource "aws_sqs_queue" "terraform_queue" {
  name                      = "terraform-queue-base-one-example"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
#   redrive_policy            = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.terraform_queue_deadletter.arn}\",\"maxReceiveCount\":4}"

  tags = {
    Environment = "dev"
  }
}
