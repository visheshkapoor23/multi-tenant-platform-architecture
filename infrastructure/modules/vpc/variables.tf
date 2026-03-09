variable "vpc_cidr" {
  description = "CIDR block for the platform VPC"
  type        = string
}

variable "public_subnets" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
}