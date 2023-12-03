
module "company" {
  source = "../../modules/company"
  region = "us-west-1"
  company_name = var.company_name
  company_vpc_cidr = var.company_vpc_cidr
  instance_name = var.instance_name
}
