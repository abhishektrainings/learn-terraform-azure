output "resource_group_name" {
  description = "Resource group name passed to the vnet module"
  value       = var.resource_group_name
}

output "vnet_id" {
  description = "Virtual network ID from the vnet module"
  value       = module.vnet.vnet_id
}