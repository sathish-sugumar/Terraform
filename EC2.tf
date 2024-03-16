terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.5.0"
    }
  }
}

provider "aws" {
 
  region="ap-southeast-1"
  # Configuration options
}
resource "aws_instance" "terraform" {

  ami     = "ami-ami-015f72d56355ebc27" 
  instance_type = "t2.micro"
  
  tags = { 
    name= "myinstance"
  }
}