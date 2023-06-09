resource "aws_instance" "ec2" {
  ami           = "data.aws_ami.ec2.id" 
  instance_type = "t2.micro"
  tags = {
    Name = ec2
  }
}


data "aws_ami" "ec2" {
  executable_users = ["self"]
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["self"]
}