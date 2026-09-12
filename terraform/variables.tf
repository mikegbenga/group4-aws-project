variable "aws_region" {
  description = "AWS region for the project"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for AWS resource naming"
  type        = string
  default     = "group4-aws-project"
}

variable "vpc_cidr" {
  description = "CIDR block for the project VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "admin_ip" {
  description = "Public IP address allowed to SSH into the EC2 instance"
  type        = string
}
variable "db_password" {
  description = "Password for the RDS PostgreSQL database"
  type        = string
  sensitive   = true
}
variable "key_name" {
  description = "AWS EC2 key pair name"
  type        = string
}