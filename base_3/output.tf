output "output_multiple_ec2_vm_complex" {
  value = aws_instance.multiple_ec2_vm_complex.*.arn
}
