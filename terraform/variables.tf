variable "vpc_cidr" {
  description = "VPC cidr block. Example: 10.0.0.0/16"
  default     = "10.100.0.0/16"
}

variable "environment" {
  description = "The name of the environment"
  default     = "jenkins"
}

variable "private_subnet_cidrs" {
  type        = "list"
  description = "List of cidrs, for every avalibility zone you want you need one. Example: 10.0.0.0/24 and 10.0.1.0/24"
  default     = ["10.100.1.0/24", "10.100.2.0/24"]
}

variable "public_subnet_cidrs" {
  type        = "list"
  description = "List of cidrs, for every avalibility zone you want you need one. Example: 10.0.0.0/24 and 10.0.1.0/24"
  default     = ["10.100.11.0/24", "10.100.12.0/24"]
}

variable "availability_zones" {
  type        = "list"
  description = "List of avalibility zones you want. Example: eu-west-1a and eu-west-1b. The amount of cidrs and availability_zones should match"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "cluster" {
  description = "The name of the ECS cluster"
  default     = "jenkins"
}
