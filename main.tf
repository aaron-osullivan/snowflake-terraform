terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.87"
    }
  }
}

provider "snowflake" {
  organization_name = var.snowflake_organization
  account_name      = var.snowflake_account_name
  username          = var.snowflake_username
  password          = var.snowflake_password
  role              = "ACCOUNTADMIN"
}

resource "snowflake_warehouse" "analytics" {
  name           = "ANALYTICS_WH_${upper(var.environment)}"
  warehouse_size = var.warehouse_size
  auto_suspend   = 60
  auto_resume    = true
  comment        = "Analytics warehouse managed by Terraform"
}

resource "snowflake_database" "analytics" {
  name    = "ANALYTICS_${upper(var.environment)}"
  comment = "Analytics database managed by Terraform"
}

resource "snowflake_schema" "raw" {
  database = snowflake_database.analytics.name
  name     = "RAW"
  comment  = "Raw ingestion layer"
}

resource "snowflake_schema" "analytics" {
  database = snowflake_database.analytics.name
  name     = "ANALYTICS"
  comment  = "Analytics layer"
}

resource "snowflake_role" "analyst" {
  name    = "ANALYST_${upper(var.environment)}"
  comment = "Analyst role managed by Terraform"
}

resource "snowflake_grant_privileges_to_account_role" "analyst_warehouse" {
  account_role_name = snowflake_role.analyst.name
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.analytics.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "analyst_database" {
  account_role_name = snowflake_role.analyst.name
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.analytics.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "analyst_schema" {
  account_role_name = snowflake_role.analyst.name
  privileges        = ["USAGE", "CREATE TABLE"]

  on_schema {
    schema_name = "\"${snowflake_database.analytics.name}\".\"${snowflake_schema.analytics.name}\""
  }
}