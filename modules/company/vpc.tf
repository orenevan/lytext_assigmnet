locals {
  environment = "stage"
  additional_aws_tags = {
    Owner      = "Company"
    Expires    = "Never"
    Department = "Engineering"
  }
  
}

module "company_vpc" {
  source                 = "squareops/vpc/aws"
  name                   = var.company_name
  vpc_cidr               = var.company_vpc_cidr
  
  environment            = local.environment
  availability_zones     = ["${var.region}a"]
  
  public_subnet_enabled  = true
  private_subnet_enabled = true
  auto_assign_public_ip  = true

}

resource "aws_security_group" "allow_icmp_company" {
  vpc_id = module.company_vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}




