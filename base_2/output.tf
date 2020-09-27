output "vm_arn" {
  value = aws_instance.vm.arn
}

output "environment" {
  value = var.env
}

output "ec2_instance_name" {
  value = local.ec2_instance_name
}
