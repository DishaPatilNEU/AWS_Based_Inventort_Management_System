variable "SecurityGroupID" {
  type = list(string)
}
variable "LB_Subnets" {
  type = list(string)
}
variable "VPC_ID" {
  type = string
}

variable "webapp_url" {
  type = string
}