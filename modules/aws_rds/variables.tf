variable "UUIDGenerated" {
  type = string
}  
variable "PrivateSubnetID" {
  type = list(string)
}
variable "PrivateSubnetName" {
  type = list(string)
}
variable "SecurityGroupID" {
  type = string
}

variable "RDSPassword" {
  type = string
}
variable "RDSUsername" {
  type = string
}

