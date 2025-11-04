provider "aws" {
  region = "us-west-2"
  profile = "terraform-personal"
}

import {

 id = "your manually created instance id"

 to = aws_instance.example
}

#Extract generate config from manual created ec2 -  terraform plan -generate-config-out=generated.tf
#Paste the config in this main.tf , comment out import block, delete generated state file
#run terraform import aws_instance.name instance-id
#Migration done!

