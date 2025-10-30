provider "aws" {
  region = "us-west-2"
  profile = "terraform-personal"
}
#create CIDR
variable "cidr" {
  default = "10.0.0.0/16"
}
#create key pair
resource "aws_key_pair" "example" {
  key_name = "terraform-demo-rahul"
  public_key = file("/Users/rahulkarmakar/Desktop/terraform-demo.pub")
}
#create vpc with cidr
resource "aws_vpc" "demo-vpc"{
    cidr_block = var.cidr
}

#creatre subnet with vpc and cidr (region specific)
resource "aws_subnet" "demo-subnet" {
  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-west-2c"
  map_public_ip_on_launch = true
}

#create igw with vpc

resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id
}
#create route table with cidr block,igw and vpc
resource "aws_route_table" "demo-route" {
  vpc_id = aws_vpc.demo-vpc.id
 route {
 cidr_block = "0.0.0.0/0"
 gateway_id = aws_internet_gateway.demo-igw.id

  }
}
#Associate route table with subnet
resource "aws_route_table_association" "rta1" {
    subnet_id = aws_subnet.demo-subnet.id
    route_table_id = aws_route_table.demo-route.id
}

#create sg with ingress and egress
resource "aws_security_group" "web-sg" {
    name= "web"
    vpc_id = aws_vpc.demo-vpc.id
 
 ingress {

description = "HTTP from VPC"
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
 }
ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
egress {
    description = "outbound"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

 tags = {
    Name = "web-sg"
  }
}

#create ec2 instance with provisioner 
resource "aws_instance" "demo-server" {
    ami = "ami-03aa99ddf5498ceb9"
    instance_type = "t2.micro"
    key_name = aws_key_pair.example.key_name
    vpc_security_group_ids = [aws_security_group.web-sg.id]
    subnet_id = aws_subnet.demo-subnet.id
 
  connection {
    
      type = "ssh"
      user = "ubuntu"
      private_key = file("/Users/rahulkarmakar/Desktop/terraform-demo")
      host = self.public_ip
  }

  provisioner "file" {
    source = "app.py"
    destination = "/home/ubuntu/app.py"

  }
 provisioner "remote-exec" {
   inline = [ 
    "echo 'Hello from ec2'",
    "sudo apt update -y",
    "sudo apt install -y python3-pip",
    "cd /home/ubuntu",
    "sudo apt install -y python3-flask",
    "nohup sudo python3 app.py &"
    ]
 }
}







