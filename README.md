# Lytex World | Oren Evan 


## Table of Contents
- [Introduction](#introduction)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Directory_Layout](#directory_layout)
- [Contributing](#contributing)

## Introduction
``Prepared by Oren Evan``
[link example](https://github.com/gruntwork-io/terragrunt-infrastructure-modules-example)
`bold`

Terraform and AWS cloud EC2 instances 
This repo is responsible for deploying companies 
in 2 different regions of the globe (in AWS).
Using Terraform and AWS cloud EC2 instances . 


The code in this repo uses the following folder hierarchy:

```
account
 └ _global
 └ region
    └ _global
    └ environment
       └ resource
```


```hcl
# referenc modules like this 
module "company" {
  source = "../../modules/company"
  region = "us-east-1"
  company_name = "companya"
  company_vpc_cidr = var.company_vpc_cidr
  instance_name = var.instance_name
}

terraform {
  source = "git::git@github.com:gruntwork-io/terragrunt-infrastructure-modules-example.git//path/to/module?ref=v0.0.1"
}

# Fill in the variables for that module
inputs = {
  foo = "bar"
  baz = 3
}


```





Main Objective:
* there are companies in 2 different regions of the globe (in AWS).
* each company needs a single ec2 instance
* each instance must be able to ping the other instance
  these computers should only be accessible by using AWS SSM in the AWS Console

Deliverable:
* Terraform code which deploys the complete infrastructure described above
* Screenshots of any behavior to show proof of connectivity

Bonus Objective:
*  a github repository for this code, in which a merge to the main branch triggers a
deployment of the entire infrastructure to the AWS account, using secrets from within that
repository and github actions

Rules:
* This task is limited to 3 hours there is no limit to the type of resources for this task. 

The areas to focus on, weighted in this order:
* Security
* Simplicity
* Documentation
* code quality



## Getting Started

Instructions for setting up the project locally.

### Prerequisites

- Terraform 
- AWS Credentials
  set aws profile with aws credentials under ~/.aws/credentials 
  make sure to add 
 [default]
  aws_access_key_id =  AWS_ACCESS_KEY_ID
  aws_secret_access_key =  AWS_SECRET_KEY

### Installation

Step-by-step instructions to install and configure the project.

1. Clone the repository: `[repository https://github.com/orenevan/lytext_assigmnet]`
2. Navigate to the project directory: `cd lytext_assigmnet`
   

Environment lifecycle

Create an environment/companya 
------------------------------
1. Change to ``environments/companya`` directory
2. terraform init 
3. terraform plan      check out that plan looks ok
4. terraform apply  

*Repeat the same for companyb 

Setup VPC Peering  
-----------------
** After you complete executing companies creation **
1. Change to ``environments/vpc_peering`` directory
2. terraform init 
3. terraform plan      check out that plan looks ok
4. terraform apply  


Destroy an environment
----------------------
1. Change to the environment directory: ``cd environment/companya``
2. Execute ``terraform destroy`` command


## Directory_Layout

Project top-level directory contains the following files.


``environments/``  subdirectory
  Each company is defined in a subdirectory of this directory. 

``modules/`` subdirectory

  Example of using company module in an environment
  is::

    module "company" {
      source = "../../modules/company"
      region = "us-east-1"
      company_name = "companya"
      company_vpc_cidr = var.company_vpc_cidr
      instance_name = var.instance_name
    }


 ``main.tf`` 
   
   Contains main code for execution 


## Contributing

Guidelines for contributing to the project. Include information about how to submit pull requests, report issues, and code standards.

1. Fork the repository
2. Create a new branch: `git checkout -b feature/your-feature-name`
3. Make your changes and commit them: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature/your-feature-name`
5. Create a pull request


![Project Screenshot](/images/screenshot.png)






