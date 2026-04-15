output "warehouse_name" {
  description = "Name of the Snowflake warehouse"
  value       = snowflake_warehouse.analytics.name
}

output "database_name" {
  description = "Name of the Snowflake database"
  value       = snowflake_database.analytics.name
}

output "analyst_role" {
  description = "Name of the analyst role"
  value       = snowflake_role.analyst.name
}