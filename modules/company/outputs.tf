
output "company_region" {
  value = "companya_region=${var.region}"
}


output "company_vpc_id" {
  description = "The ID of the VPC"
  value       = module.company_vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "AWS Region"
  value       = module.company_vpc.vpc_cidr_block
}

output "var_company_vpc_cidr" {
  description = "vpc cidr"
  value       = var.company_vpc_cidr
}


output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.company_vpc.public_subnets
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.company_vpc.private_subnets
}