env = "prod"
instance_type = "t2.micro"
os = "Linux"

single_vm_tags = {
  "os" : "Linux",
  "type": "Very Simple",
  "Name": "prod_simple"
}

multiple_ec2_vm_simple = ["one", "two"]

multiple_ec2_vm_complex_data = [
  {
    "name" : "foo_complex",
    "instance_type" : "t2.micro",
    "tags" : {
        "machine_id" : "1",
        "os" : "Linux",
        "project" : "base_3"
    }
  },
  {
    "name" : "bar_complex",
    "instance_type" : "t2.micro",
    "tags" : {
        "machine_id" : "2",
        "os" : "Linux",
        "project" : "base_3"
    }
  }
]

dynamodb = {
  "name" = "my_dynamo_table"
  "billing_mode" = "PROVISIONED"
  "read_capacity" = 20
  "write_capacity" = 20
  "hash_key" = "UserId"
  "range_key" = "GameTitle"
  "attributes" = [
    {
      "name": "UserId",
      "type": "S"
    },
    {
      "name": "GameTitle",
      "type": "S"
    }
  ]
  "tags": {
    "tag_value": "my_value"
  }
}


