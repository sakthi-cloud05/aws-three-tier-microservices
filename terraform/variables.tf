variable "aws_region" {
  description = "AWS Region for deployment"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project prefix for resource naming"
  type        = string
  default     = "prod-three-tier"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnets across 2 Availability Zones for ALB"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private subnets across 2 Availability Zones for ECS & EFS"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}
