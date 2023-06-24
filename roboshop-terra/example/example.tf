resource "aws_instance" "ec2" {
  ami           = "data.aws_ami.ec2.id" 
  instance_type = "t2.micro"
  tags = {
    Name = ec2
  }
}