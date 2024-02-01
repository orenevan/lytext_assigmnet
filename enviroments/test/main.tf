module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}




# Get latest Amazon Linux 2 AMI
data "aws_ami" "amazon-linux-2" {
 
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


resource "aws_security_group" "allow_icmp_company" {
  vpc_id = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_key_pair" "key" {
  key_name   = "ssh-key"
  public_key = file("~/.ssh/id_rsa.pub")
}




resource "aws_instance" "amazon_linux2" {
 
  instance_type = "t2.micro"
  ami =  data.aws_ami.amazon-linux-2.id 
  key_name                    = aws_key_pair.key.key_name

  subnet_id              = module.vpc.private_subnets[0]
  associate_public_ip_address = false
  #iam_instance_profile =  "${aws_iam_instance_profile.ssm_instance_profile.name}"
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
    Name = "private_instance"
  }

}




resource "aws_instance" "amazon_linux3" {
 
  instance_type = "t2.micro"
  ami =  data.aws_ami.amazon-linux-2.id 
  key_name                    = aws_key_pair.key.key_name

  subnet_id              = module.vpc.private_subnets[0]
  associate_public_ip_address = true
  #iam_instance_profile =  "${aws_iam_instance_profile.ssm_instance_profile.name}"
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
    Name = "public_instance"
  }

}
