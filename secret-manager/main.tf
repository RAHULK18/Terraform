provider "aws" {
      region = "us-west-2"
      profile = "terraform-personal"
}
variable "ami" {
     description = "AMI"
}

variable "instance_type" {
      description = "Instance Type"
  
}
variable "aws_key_pair" {
      description = "Key pair"
}

variable "instance_name" {
  description = "EC2 Instance Name"
}



resource "aws_instance" "terraform-ec2" {
      ami =var.ami
      instance_type = var.instance_type
      key_name = var.aws_key_pair
      tags = {
            Name = var.instance_name
            Enviroment = "dev"
      
      }
}






