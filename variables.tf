variable "subscription_id" {
  description = "The subscription ID for the Azure account."
  type        = string
}

variable "client_id" {
  description = "The client ID for Azure authentication."
  type        = string
}

variable "client_secret" {
  description = "The client secret for Azure authentication."
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "The tenant ID for the Azure account."
  type        = string
}