# Snowflake Infrastructure as Code

Terraform project provisioning a fully managed Snowflake data platform environment, including warehouse, database, schemas, and RBAC roles. 
Uses remote state in AWS S3 and DynamoDB state locking.

## What's Provisioned

- Snowflake warehouse with auto-suspend and auto-resume
- Database and schemas (RAW and ANALYTICS layers)
- RBAC roles with appropriate grants
- Environment-based naming (dev/stg/prd)

## Tech Stack

- Terraform ~> 1.14
- Snowflake provider (Snowflake-Labs/snowflake)
- AWS S3 remote state with DynamoDB state locking

## Usage

Set environment variables for sensitive values:
```powershell
$env:TF_VAR_snowflake_organization="*****"
$env:TF_VAR_snowflake_account_name="*****"
$env:TF_VAR_snowflake_username="*****"
$env:TF_VAR_snowflake_password="*****"
```

Then run:
```bash
terraform init
terraform plan
terraform apply
```

## Environment Variables

| Variable | Description |
|---|---|
| TF_VAR_snowflake_organization | Snowflake organization name |
| TF_VAR_snowflake_account_name | Snowflake account name |
| TF_VAR_snowflake_username | Snowflake login username |
| TF_VAR_snowflake_password | Snowflake login password |

## Author

Aaron O'Sullivan — Data Platform Engineer — Cork, Ireland
