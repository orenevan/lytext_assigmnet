
variable "alias" {
  description = "Provider alias"
   default = "alias"
}

variable "company_name" {
  description = "company name"
  default = "company_name"
  
}

variable "region" {
  description = "AWS region"
  default = "us-east-1"
  
}

variable "instance_name" {
  description = "EC2 instance name"
   default = "ssminstancea"
  
}

variable "company_vpc_cidr" {
  description = "company vpc cidr"
  default = "10.1.0.0/16"
  
}



