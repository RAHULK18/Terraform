variable "instance_type" {
      type = string
      default = "t2.micro"
}

variable "ami_id"{
     type = string
    # default = "ami-0e1d35993cb249cee"
}

provider "aws" {
      region = "us-west-2"
      profile = "terraform-personal"
}

resource "aws_instance" "terraform-ec2-var" {
      ami =var.ami_id
      instance_type = var.instance_type
}

output "public_ip" {
   value = aws_instance.terraform-ec2-var.instance_state

}