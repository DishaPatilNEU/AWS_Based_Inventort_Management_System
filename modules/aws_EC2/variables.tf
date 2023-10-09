
variable "instanceType" {
  type        = string
  default     = "t2.micro"
}
variable "vpcInstanceID" {
  type        = string
}
variable "publicKeyPath" {
  default     = "C:/Users/Lenovo/.ssh/ec2.pub"
}

variable "s3BucketName" {
  type = string
}
variable "SubnetID" {
  type        = string
}
variable "KeyPairName" {
  type        = string
}

variable "RDSPassword" {
  type = string
}
variable "RDSEndpoint" {
  type = string
}
variable "SecurityGroupID" {
  type        = list(string)
}
variable "RDSUsername" {
  type = string
}
variable "access_policy_attachemet_name" {
  type = string
}
variable "amiID" {
  description = "Id for AMI"
}



