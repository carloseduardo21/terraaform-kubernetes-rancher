# Required
variable "aws_access_key" {
  type        = string
  description = "AWS access key used to create infrastructure"
}

# Required
variable "aws_secret_key" {
  type        = string
  description = "AWS secret key used to create AWS infrastructure"
}

# Required
variable "aws_region" {
  type        = string
  description = "AWS region used for all resources"
  default     = "us-west-1"
}

variable "aws_zone" {
  type        = string
  description = "AWS zone used for all resources"
  default     = "us-west-1a"
}

variable "prefix" {
  type        = string
  description = "Prefix added to names of all resources"
  default     = "terraform-setup"
}

variable "instance_type" {
  type        = string
  description = "Instance type used for all EC2 instances"
  default     = "t3a.medium"
}

variable "instance_ami_id" {
  type        = string
  description = "AMI Id to Instance"
  default     = "ami-0ce2cb35386fc22e9"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
  default     = "vpc-0bab5e8611149833e"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID"
  default     = "subnet-0749ae93be838c529"
}