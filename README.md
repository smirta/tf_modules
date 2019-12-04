# tf_module_test

This repository provides a Terraform module for AWS networking.

## Purpose
Specifically, it contains a basic set of configuration for accessing [Amazon Machine Images (AMI)](https://www.terraform.io/docs/providers/aws/r/ami.html).

This is achived by encapsulating following [AWS virtual private cloud (VPC) Terraform resources](https://www.terraform.io/docs/providers/aws/):
* [aws_vpc](https://www.terraform.io/docs/providers/aws/r/vpc.html)
* [aws_subnet](https://www.terraform.io/docs/providers/aws/d/subnet.html)
* [aws_internet_gateway](https://www.terraform.io/docs/providers/aws/d/internet_gateway.html)
* [aws_route_table](https://www.terraform.io/docs/providers/aws/d/route_table.html)
* [aws_route_table_association](https://www.terraform.io/docs/providers/aws/r/route_table_association.html)

## Usage
The module can be imported as follows (adapt network cidr and availability zone as needed):
```
module "networking" {
  source = "github.com/smirta/tf_module_test"
  cidr = "10.0.10.0/24"
  az = "us-west-2a"
}
```

The modules outputs can be accessed via the following variables:
* Subnet Id: `module.networking.main-subnet-id`
* VPC Id: `module.networking.main-vpc-id`
* CIDR of the Subnet: `module.networking.showCIDR`