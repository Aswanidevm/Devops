provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0bdc2b492d734dc19" 

  tags = {
    Name = "${name}"
  }
}