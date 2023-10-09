variable "vpc_ID" {
  type        = string
  
}


variable "CIDR_Block" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
}


