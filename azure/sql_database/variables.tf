# variable "sql_server_resource_group_name" {
#   description = "The name of the resource group in which the SQL server exists."
#   type        = string
# }

variable "location" {
  description = "The location where the SQL Server will be created"
  type        = string
}

variable "environment" {
  description = "Defines the environment to provision the resources."
  type        = string
  validation {
    condition     = contains(["dev", "test", "sand", "prod"], var.environment)
    error_message = format("Invalid value '%s' for variable 'environment', valid options are 'dev', 'test', 'sand', 'prod'.", var.environment)
  }
}

# variable "sql_server_name" {
#   description = "The name of the SQL Server to connect to"
#   type        = string
#   validation {
#     condition     = var.sql_server_name != "" && var.sql_server_name != null 
#     error_message = "Variable 'sql_server_name' cannot be empty."
#   }
# }

variable "sql_server_settings" {
  description = "SQL server settings."
  type = object({
    name                = string
    resource_group_name = string
  })

}

variable "sql_elastic_pool_name" {
  description = "The name of the elastic pool to add the database to"
  type        = string
  default     = null
  nullable    = true
}

variable "workload" {
  description = "Name of the database to create"
  type        = string
}

variable "override_name" {
  description = "Override the name of the SQL database, to bypass naming convention"
  type        = string
  default     = null
  nullable    = true
}

variable "collation" {
  description = "The collation to use for the database"
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "license_type" {
  description = "The license type to apply for this database"
  type        = string
  default     = "BasePrice"
  validation {
    condition     = contains(["LicenseIncluded", "BasePrice"], var.license_type)
    error_message = format("Invalid value '%s' for variable 'license_type', valid options are 'LicenseIncluded', 'BasePrice'.", var.license_type)
  }
}

variable "sku_name" {
  description = "The name of the SKU used by the database"
  type        = string
  default     = "S0"

  validation {
    condition     = contains(["S0", "S1", "S2", "S3", "S4", "GP_Gen5_2", "GP_Gen5_4", "GP_Gen5_6", "GP_Gen5_8", "GP_Gen5_10", "GP_Gen5_12", "GP_Gen5_14", "GP_Gen5_16", "GP_Gen5_18", "GP_Gen5_20"], var.sku_name)
    error_message = format("Invalid value '%s' for variable 'sku_name', valid options are 'S0', 'S1', 'S2', 'S3', 'S4', 'GP_Gen5_2', 'GP_Gen5_4', 'GP_Gen5_6', 'GP_Gen5_8', 'GP_Gen5_10', 'GP_Gen5_12', 'GP_Gen5_14', 'GP_Gen5_16', 'GP_Gen5_18', 'GP_Gen5_20'.", var.sku_name)
  }
}

variable "max_size_gb" {
  description = "The maximum size of the database in gigabytes, if it's inside an elastic pool this will be ignored and will use 1TB as max size."
  type        = number
  default     = 250
}

variable "instance_count" {
  description = "A numeric sequence number used for naming the resource. It ensures a unique identifier for each resource instance within the naming convention."
  type        = number

  validation {
    condition     = var.instance_count >= 1 && var.instance_count <= 999
    error_message = format("Invalid value '%s' for variable 'instance_count'. It must be between 1 and 999.", var.instance_count)
  }
}
