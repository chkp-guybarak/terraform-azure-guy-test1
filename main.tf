provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id

  features {}
}


# Main Module Invocation
module "single_gateway_new_vnet" {
  source = "./modules/single-gateway-new-vnet"
  
  # Basic Configuration
  single_gateway_name          = "guy-gateway3"
  resource_group_name          = "guy-resource-group3"
  location                     = "East US"
  admin_password               = "YourSecurePassword123!"
  template_name                = "single"
  template_version             = "20230910"
  installation_type            = "gateway"
  vm_size                      = "Standard_DS3_v2"
  disk_size                    = "100"
  os_version                   = "R8120"
  vm_os_sku                    = "sg-byol"
  vm_os_offer                  = "check-point-cg-r8120"
  allow_upload_download        = true
  authentication_type          = "Password"
  serial_console_password_hash = ""
  maintenance_mode_password_hash = ""
  bootstrap_script             = "touch /home/admin/bootstrap.txt; echo 'hello_world' > /home/admin/bootstrap.txt"

  # Networking
  vnet_name            = "guy-vnet3"
  address_space        = "10.12.0.0/16"
  frontend_subnet_prefix = "10.12.0.0/24"
  backend_subnet_prefix  = "10.12.1.0/24"
  nsg_id               = ""

  # Public IP
  vnet_allocation_method = "Static"
  sku                    = "Standard"

  # Additional configurations
  management_GUI_client_network = "0.0.0.0/0"
  is_blink                      = true
  admin_shell                   = "/etc/cli.sh"
  sic_key                       = "guy-sic-key-123456"
  smart_1_cloud_token           = "your-smart-1-cloud-token"
}
