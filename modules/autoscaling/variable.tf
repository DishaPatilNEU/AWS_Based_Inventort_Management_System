variable "AMI_ID" {
  description = "Id for AMI"
}
variable "subnetID" {
  type        = list(string)
  description = "id for the subnet"
}
variable "instanceType" {
  type        = string
  description = "Type of instance"
  default     = "t2.micro"
}
variable "publicKeyPath" {
  description = "Public key path"
   default     = "C:/Users/Lenovo/.ssh/ec2.pub"
}
variable "RDSEndpoint" {
  type = string
}
variable "cooldownPeriod" {
  type    = number
  default = 60
}
variable "RDSUsername" {
  type = string
}
variable "securityGroupID" {
  type        = list(string)
  description = "ID for the security group"
}

variable "RDSPassword" {
  type = string
}
variable "access_policy_attachemet_name" {
  type = string
}

variable "S3_BucketName" {
  type = string
}
variable "IB_TargetGroupARN" {
  type = string
}




