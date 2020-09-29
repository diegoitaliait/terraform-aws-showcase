env = "dev"
instance_type = "t2.micro"
os = "Linux"

single_vm_tags = {
  "os" : "Linux",
  "type": "Simple",
  "Name": "Simple"
}

multiple_ec2_vm_simple = ["one", "two"]

multiple_ec2_vm_with_validation = [
  {
    "name" : "foo_complex",
    "instance_type" : "t2.micro",
    "instance_state" : "terminated",
    "tags" : {
        "machine_id" : "1",
        "os" : "Linux",
        "project" : "base_3"
    }
  },
  {
    "name" : "bar_complex",
    "instance_type" : "t2.micro",
    "instance_state" : "shutting-down",
    "tags" : {
        "machine_id" : "2",
        "os" : "Linux",
        "project" : "base_3"
    }
  }
]


