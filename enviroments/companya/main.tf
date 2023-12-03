
module "company" {
  source = "../../modules/company"
  region = "us-east-1"
  company_name = "companya"
  company_vpc_cidr = var.company_vpc_cidr
  instance_name = var.instance_name
}
