module "IP_subnet" {
  source          = "./modules/aws_subnets"
  VPC_CIDR_Value  = var.vpc_cidr_value
  vpc_instance_id = module.vpc.vpc_instance_id
}

provider "aws" {
  profile = var.aws_default_profile
  region  = var.aws_default_region
}

resource "random_uuid" "uuid" {}
module "vpc" {
  VPC_CIDR_Value = var.vpc_cidr_value
  source         = "./modules/aws_vpc"
 
}


module "routingTable" {
  source            = "./modules/aws_route_tables"
  vpc_instance_id   = module.vpc.vpc_instance_id
  PublicSubnetID  = module.IP_subnet.public_subnet_id
  igw_id            = module.vpc.internet_gateway_id
  PrivateSubnetID = module.IP_subnet.private_subnet_id
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.46"
    }
  }
}


module "cloud_security_group" {
  source = "./modules/aws_security_group"
  vpc_ID = module.vpc.vpc_instance_id
}

module "iam_access_roles" {
  source = "./modules/aws_iam_roles"
  AWS_S3_ARN = module.s3_Storage.aws_s3_arn
}

module "aws_route53" {
  source ="./modules/aws_route53"
  LB_DNS= module.LoadBalancer.DNS_LoadBalancer
  LBZoneID= module.LoadBalancer.LBZoneID
  route53_url=var.route53_url
}



module "aws_rds" {
  source              = "./modules/aws_rds"
  RDSUsername                  = var.rds_username
  RDSPassword                  = var.rds_password
  SecurityGroupID   = module.cloud_security_group.database_security_group_id
  PrivateSubnetID   = module.IP_subnet.private_subnet_id
  UUIDGenerated      = random_uuid.uuid.result
  PrivateSubnetName = module.IP_subnet.private_subnet_name
}
module "s3_Storage" {
  AWSDefaultProfile = var.aws_default_profile
  source              = "./modules/aws_s3"
}


module "LoadBalancer" {
  source            = "./modules/LoadBalancer"
  SecurityGroupID = [module.cloud_security_group.load_balancer_security_group]
  LB_Subnets        = module.IP_subnet.public_subnet_id
  VPC_ID            = module.vpc.vpc_instance_id
  webapp_url        = var.route53_url
}

module "autoscaling" {
  source                        = "./modules/autoscaling"
  AMI_ID                       = var.ami_id
  securityGroupID             = [module.cloud_security_group.application_security_group_id]
  subnetID                     = module.IP_subnet.public_subnet_id
  access_policy_attachemet_name = module.iam_access_roles.access_policy_attachemet_name
  RDSEndpoint                  = module.aws_rds.rds_endpoint
  RDSUsername                  = var.rds_username
  RDSPassword                  = var.rds_password
  S3_BucketName                = module.s3_Storage.aws_bucket_name
  IB_TargetGroupARN           = module.LoadBalancer.LBTargetGroupARN
}


