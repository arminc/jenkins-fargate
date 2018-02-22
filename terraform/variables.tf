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

variable "deregistration_delay" {
  default     = "60"
  description = "The default deregistration delay"
}

variable "http_health_check_interval" {
  default     = 30
  description = "The default http health check interval"
}

variable "http_health_check_path" {
  default     = "/"
  description = "The default http health check path"
}

variable "http_health_check_port" {
  default     = "8080"
  description = "The default http health check port"
}

variable "http_health_check_protocol" {
  default     = "HTTP"
  description = "The default http health check protocol"
}

variable "http_health_check_timeout" {
  default     = 5
  description = "The default http health check timeout"
}

variable "http_health_check_healthy_threshold" {
  default     = 3
  description = "The default http health check healthy threshold"
}

variable "http_health_check_unhealthy_threshold" {
  default     = 3
  description = "The default http health check unhealthy threshold"
}

variable "http_health_check_matcher" {
  default     = "403"
  description = "The default http matcher (HTTP CODE)"
}
