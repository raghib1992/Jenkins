provider "aws" {
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_instance" "israr" {
    ami = ""
    instance_type = "t2.micro"  
}