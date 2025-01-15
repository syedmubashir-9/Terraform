# variables.tf

variable "region" {
  description = "The AWS region for the deployment"
  type        = string
}

variable "allocated_storage" {
  description = "The amount of storage (in GB) to allocate for the database"
  type        = number
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "engine" {
  description = "The database engine"
  type        = string
}

variable "engine_version" {
  description = "The version of the database engine"
  type        = string
}

variable "instance_class" {
  description = "The instance class for the database"
  type        = string
}

variable "username" {
  description = "The username for the database"
  type        = string
}

variable "password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "parameter_group_name" {
  description = "The name of the DB parameter group"
  type        = string
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot when deleting the DB instance"
  type        = bool
}
