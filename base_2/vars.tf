variable "env" {
  description = "Environment"
}

variable "instance_type" {
  description = " The type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance."
  default     = "t2.micro"
}

variable "os" {
  description = "OS name"
  default     = "Generic"
}


locals {
  ec2_instance_name = "micro_vm_${var.env}"
}


