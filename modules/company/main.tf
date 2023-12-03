

# Get latest Amazon Linux 2 AMI
data "aws_ami" "amazon-linux-2" {
 
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


resource "aws_instance" "amazon_linux2" {
 
  instance_type = "t2.micro"
  ami =  data.aws_ami.amazon-linux-2.id 
   
  subnet_id              = module.company_vpc.private_subnets[0]
  associate_public_ip_address = false
  iam_instance_profile =  "${aws_iam_instance_profile.ssm_instance_profile.name}"
  security_groups             = [aws_security_group.allow_icmp_company.id]
  
  lifecycle {
    # The AMI ID must refer to an AMI that contains an operating system
    # for the `x86_64` architecture. && name = amzn2-ami-hvm*
   
    precondition {
      condition     = data.aws_ami.amazon-linux-2.architecture == "x86_64" && can(regex("amzn2-ami-hvm*" ,data.aws_ami.amazon-linux-2.name ))
      error_message = "The selected AMI must be for the x86_64 architecture && Amazon Linux 2023 AMI"
    }
  
  }
  tags = {
    Name = var.instance_name
  }

}


