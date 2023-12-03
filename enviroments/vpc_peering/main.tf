

data "terraform_remote_state" "companyb" {
  backend = "local"

  config = {
    path = "../companyb/terraform.tfstate"
  }
}

data "terraform_remote_state" "companya" {
  backend = "local"
  config = {
    path = "../companya/terraform.tfstate"
  }
}


locals {
  companya_vpc_id = data.terraform_remote_state.companya.outputs.company_vpc_id
  companyb_vpc_id = data.terraform_remote_state.companyb.outputs.company_vpc_id
 
  
  company_a_name        = "company_a"
  company_a_region      = "us-east-1"
  company_a_environment = "stage"
  company_b_name        = "company_b"
  company_b_region      = "us-west-1"
  company_b_environment = "stage"
  additional_aws_tags = {
    Owner      = "Company"
    Expires    = "Never"
    Department = "Engineering"
  }
  company_a_vpc_cidr = "10.0.0.0/16"
  company_b_vpc_cidr = "10.1.0.0/16"
  
}

module "vpc_peering" {
  source               = "squareops/vpc/aws//modules/vpc_peering"
  accepter_name        = local.company_a_name
  accepter_vpc_id      = local.companya_vpc_id 
  accepter_vpc_region  = local.company_a_region
  requester_name       = local.company_b_name
  requester_vpc_id     = local.companyb_vpc_id
  requester_vpc_region = local.company_b_region
}

output "companya_vpc_id" {
  value = local.companya_vpc_id
}

output "companyb_vpc_id" {
  value = local.companyb_vpc_id
}

