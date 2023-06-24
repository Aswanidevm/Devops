provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0bdc2b492d734dc19" 
  instance_type = "t2.micro"
  tags = {
    Name = "${name}"
  }
}