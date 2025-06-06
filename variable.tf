
variable "vpc_config" {
description = "This variable contain the cidr_block and vpc name"
  type = object({
    cidr_block = string
    name       = string
  })

  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "The variable vpc_cidr must contain a valid CIDR block"
  }

}

variable "subnet_config" {
  description = <<EOT
  Accepts a map of subnets  
  cidr_block : The CIDR block of the subnet 
  public " Wheather the subnet should be public or not(default = false)
  az : availability zone depending on your region

  EOT
  type = map(object({
    cidr_block = string
    public     = optional(bool, false)
    az         = string
  }))
  validation {
    condition = alltrue([
      for config in values(var.subnet_config) : can(cidrnetmask(config.cidr_block))
    ])
    error_message = "The variable vpc_cidr must contain a valid CIDR block"
  }

}