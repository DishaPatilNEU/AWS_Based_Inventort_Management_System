
variable "ami_id" {
  description = "ami_id"
}

variable "aws_default_region" {
  type        = string
  description = "Region used in aws"
  default     = "us-east-1"
}

variable "rds_username" {
  type = string
}


variable "aws_default_profile" {
  type        = string
  description = "Profile used in aws"
}


variable "vpc_cidr_value" {
  type        = string
  description = "Cidr for main vpc"
  default     = "10.0.0.0/16"
}

variable "rds_password" {
  type = string
}

variable "route53_url" {
   type = string
}
