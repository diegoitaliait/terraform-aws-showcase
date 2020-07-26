provider "aws" {
  version = "2.70.0"
}

resource "aws_sqs_queue" "terraform_queue" {
  name                      = "terraform-queue-base-one-example"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  tags = {
    Environment = "dev"
  }
}
