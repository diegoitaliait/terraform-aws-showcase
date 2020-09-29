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

variable "single_vm_tags" {
  type = map
}

variable "multiple_ec2_vm_simple" {
  description = "Multiple ec2 vms, with a simple iteration"
  default     = []
  type        = list
}

variable "multiple_ec2_vm_simple_metadata_options" {
  description = "Multiple ec2 vms, with a simple iteration"
  default     = {}
  type        = map
}

variable "multiple_ec2_vm_with_validation" {
  description = "Multiple ec2 vms, with a complex data structure and type validation"
  default     = []
  type        = list(
    object({
      name = string
      instance_type = string
      instance_state = string
      tags = map(any)
    })
  )
}

################################################
######### Dynamic Attributes ###################
################################################

variable "dynamodb" {
  description = "DynamoDB Object"
  type        = object({
      name = string
      billing_mode = string
      read_capacity = number
      write_capacity = number
      hash_key = string
      range_key = string
      attributes = list(
        object({
          name = string
          type = string
        })
      )
      tags = map(any)
  })
}


### LOCALS

locals {
  ec2_instance_name = "${var.env}_micro_vm"
}


