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

variable "multiple_ec2_vm_simple" {
  description = "Multiple ec2 vms, with a simple iteration"
  default     = []
  type        = list
}

variable "multiple_ec2_vm_simple_matadata_options" {
  description = "Multiple ec2 vms, with a simple iteration"
  default     = {}
  type        = map
}

variable "multiple_ec2_vm_with_validation" {
  description = "Multiple ec2 vms, with a complex data structure and type validation"
  default     = []
  type        = list(
    object({
      instance_type = string
      instance_state = string
      tags = map(any)
      metadata_options = map(any)
    })
  )
}

### LOCALS

locals {
  ec2_instance_name = "${var.env}_micro_vm"
}


