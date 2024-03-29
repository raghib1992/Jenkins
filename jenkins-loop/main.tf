data "aws_ami" "amazon-linux-2" {
 most_recent = true
 owners      = ["amazon"]

 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*-x86_64-ebs"]
 }
}

resource "aws_instance" "test" {
  ami = data.aws_ami.amazon-linux-2.id
  instance_type = "t3.micro"
  tags = {
    Name = var.region
  }
}
