provider "aws" {
 region = "us-west-2"
 profile = "terraform-personal"
}

resource "aws_instance" "module-ec2" {
  ami = var.ami_value
  instance_type = var.instance_type_value
}
