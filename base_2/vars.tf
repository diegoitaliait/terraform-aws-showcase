variable "env" {
  description = "Environment"
  type        = string
}

variable "instance_type" {
  description = " The type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance."
  default     = "t2.micro"
  type        = string
}

variable "os" {
  description = "OS name"
  default     = "Generic"
  type        = string
}

variable "my_number_gt_7" {
  description = "This variable can be only a number"
  default     = 7
  type        = number

  validation {
    condition     = var.my_number_gt_7 >= 7 
    error_message = "the number must be greater than or equal to 7"
  }
}

variable "my_bool" {
  description = "This variable can be only a boolean"
  default     = false
  type        = bool
}

### LOCALS

locals {
  ec2_instance_name = "${var.env}_micro_vm"
}


