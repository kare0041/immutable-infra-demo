variable "location" {
  description = "Azure region to deploy resources"
  default     = "East US"
}

variable "resource_group_name" {
  description = "Azure resource group name"
  default     = "ImmutableInfraRG"
}

variable "image_name" {
  description = "Name of the custom image in Azure"
  default     = "golden-image-demo"
}

variable "admin_username" {
  description = "Username for the Azure VM"
  default     = "azureuser"
}

variable "admin_password" {
  description = "Password for the Azure VM (avoid using plaintext in production)"
  default     = "Azure123456!"  # 🔐 DEMO ONLY. Use a secure vault in production.
  sensitive   = true
}

variable "subscription_id" {
  description = "Azure subscription ID"
  default     = "a45f626d-5ae3-4176-ac41-2a5a558301a5"
  type        = string
}

variable "environment" {
  description = "Environment label (dev, staging, prod)"
  type        = string
  default     = "dev"
}