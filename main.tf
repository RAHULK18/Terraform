provider "aws" {
  region  = "us-west-2"
  profile = "terraform-personal"
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_security_group" "default_vpc_rk" {
  vpc_id = aws_default_vpc.default.id

  ingress {
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "default-sg-docker"
  }
}

resource "aws_key_pair" "demo_key" {
  key_name   = "jenkins-demo-rahul"
  public_key = file("/Users/rahulkarmakar/Desktop/terraform-demo.pub")
}

resource "aws_instance" "terraform_ec2" {
  ami                    = "ami-0786adace1541ca80"
  instance_type          = "t2.medium"
  key_name               = aws_key_pair.demo_key.key_name
  vpc_security_group_ids = [aws_default_security_group.default_vpc_rk.id]
root_block_device {
    volume_size = 15
    volume_type = "gp3"
    delete_on_termination = true
  }
  tags = {
    Name = "jenkins-rk"
  }
}
