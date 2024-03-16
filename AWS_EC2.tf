terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.5.0"
    }
  }
}

provider "aws" {
 
  region="ap-southeast-1"  # region configuration
  # Configuration options
}


# creating instance
resource "aws_instance" "terraform" {


  count = 2              # will create 2 instance
  ami     = "ami-015f72d56355ebc27" # amazon linux machine
  instance_type = "t2.micro"
  security_groups = [aws_security_group.MySG.name]  # using the sercurity group calling as MySG

  tags = { 
    name= "myinstance"
  }
}

# creating security group name as MYSG
resource "aws_security_group" "MySG" {
  
  
  name        = "MySG1"
  description = "Allow SSH  traffic only "
 

  ingress {
    description      = "setting inbound rule  protocol SSG port 22 "
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  
  ingress {
    description      = "setting inbound rule  protocol  http  port  80 "
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "MYSG"
  }
  
}


