variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "myTFResourceGroup"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "location" {
  description = "Azure region for resources (e.g., 'East US', 'West Europe')"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network in CIDR notation (e.g., ['10.0.0.0/16'])"
  type        = list(string)
}