variable "snowflake_username" {
  description = "Snowflake username"
  type        = string
  sensitive   = true
}

variable "snowflake_password" {
  description = "Snowflake password"
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "warehouse_size" {
  description = "Snowflake warehouse size"
  type        = string
  default     = "X-SMALL"
}

variable "snowflake_organization" {
  description = "Snowflake organization name"
  type        = string
  sensitive   = true
}

variable "snowflake_account_name" {
  description = "Snowflake account name"
  type        = string
  sensitive   = true
}