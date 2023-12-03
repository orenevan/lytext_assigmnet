
variable "alias" {
  description = "Provider alias"
  default     = "us_east_1"
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
   default = "ssminstanceb"
  
}

variable "company_vpc_cidr" {
  description = "company vpc cidr"
  default = "11.0.0.0/16"
  
}

