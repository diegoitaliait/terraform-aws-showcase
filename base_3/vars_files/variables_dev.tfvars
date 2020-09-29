env = "dev"
instance_type = "t2.micro"
os = "Linux"
multiple_ec2_vm_simple = ["one", "two"]
multiple_ec2_vm_simple_matadata_options = {
  "http_tokens" = "required"
  "http_put_response_hop_limit" = "1"
}
multiple_ec2_vm_with_validation = [
  {
    "instance_type" : "t2.micro",
    "instance_state" : "terminated",
    "tags" : {
        "machine_id" : "1",
        "os" : "Linux",
        "project" : "base_3"
    }
  },
  {
    "instance_type" : "t2.micro",
    "instance_state" : "shutting-down",
    "tags" : {
        "machine_id" : "2",
        "os" : "Linux",
        "project" : "base_3"
    }
  }
]


