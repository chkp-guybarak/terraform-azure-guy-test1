//********************** Basic Configuration Variables **************************//
variable "single_gateway_name" {
  description = "Single gateway name"
  type = string
}

variable "resource_group_name" {
  description = "Azure Resource Group name to build into"
  type = string
}

variable "location" {
  description = "The location/region where resource will be created. The full list of Azure regions can be found at https://azure.microsoft.com/regions"
  type = string
}

//********************** Virtual Machine Instances Variables **************************//
variable "source_image_vhd_uri" {
  type = string
  description = "The URI of the blob containing the development image. Please use noCustomUri if you want to use marketplace images."
  default = "noCustomUri"
}

variable "admin_username" {
  description = "Administrator username of deployed VM. Due to Azure limitations 'notused' name can be used"
  default = "notused"
}

variable "admin_password" {
  description = "Administrator password of deployed Virtual Machine. The password must meet the complexity requirements of Azure"
  type = string
}

variable "smart_1_cloud_token" {
  description = "Smart-1 Cloud Token"
  type = string
}

variable "serial_console_password_hash" {
  description = "Optional parameter, used to enable serial console connection in case of SSH key as authentication type"
  type = string
}

variable "maintenance_mode_password_hash" {
  description = "Maintenance mode password hash, relevant only for R81.20 and higher versions"
  type = string
}

variable "authentication_type" {
  description = "Specifies whether a password authentication or SSH Public Key authentication should be used"
  type = string
}
locals { // locals for 'authentication_type' allowed values
  authentication_type_allowed_values = [
    "Password",
    "SSH Public Key"
  ]
  // will fail if [var.authentication_type] is invalid:
  validate_authentication_type_value = index(local.authentication_type_allowed_values, var.authentication_type)
}

variable "template_name" {
  description = "Template name. Should be defined according to deployment type(mgmt, ha, vmss, sg)"
  type = string
  default = "single"
}

variable "template_version" {
  description = "Template version. It is recommended to always use the latest template version"
  type = string
  default = "20230910"
}

variable "installation_type" {
  description = "installation type"
  type = string
  default = "gateway"
}

locals { // locals for 'installation_type' allowed values
  installation_type_allowed_values = [
    "gateway",
    "standalone"
  ]
}

variable "vm_size" {
  description = "Specifies size of Virtual Machine"
  type = string
}

variable "disk_size" {
  description = "Storage data disk size size(GB). Select a number between 100 and 3995"
  type = string
}

variable "os_version" {
  description = "GAIA OS version"
  type = string
}

locals { // locals for 'vm_os_offer' allowed values
  os_version_allowed_values = [
    "R81",
    "R8110",
    "R8120",
    "R82"
  ]
  // will fail if [var.os_version] is invalid:
  validate_os_version_value = index(local.os_version_allowed_values, var.os_version)
}

variable "vm_os_sku" {
  description = "The sku of the image to be deployed."
  type = string
}

variable "vm_os_offer" {
  description = "The name of the image offer to be deployed.Choose from: check-point-cg-r81, check-point-cg-r8110, check-point-cg-r8120, check-point-cg-r82"
  type = string
}

locals { // locals for 'vm_os_offer' allowed values
  vm_os_offer_allowed_values = [
    "check-point-cg-r81",
    "check-point-cg-r8110",
    "check-point-cg-r8120",
    "check-point-cg-r82"
  ]
  // will fail if [var.vm_os_offer] is invalid:
  validate_os_offer_value = index(local.vm_os_offer_allowed_values, var.vm_os_offer)
}

variable "allow_upload_download" {
  description = "Automatically download Blade Contracts and other important data. Improve product experience by sending data to Check Point"
  type = bool
}

variable "enable_custom_metrics" {
  description = "Indicates whether CloudGuard Metrics will be use for Cluster members monitoring."
  type = bool
  default = true
}

variable "is_blink" {
  description = "Define if blink image is used for deployment"
  default = true
}

variable "admin_shell" {
  description = "The admin shell to configure on machine or the first time"
  type = string
  default = "/etc/cli.sh"
}

locals {
  admin_shell_allowed_values = [
    "/etc/cli.sh",
    "/bin/bash",
    "/bin/csh",
    "/bin/tcsh"
  ]
  // Will fail if [var.admin_shell] is invalid
  validate_admin_shell_value = index(local.admin_shell_allowed_values, var.admin_shell)
}

//********************** Networking Variables **************************//
variable "vnet_name" {
  description = "Virtual Network name"
  type = string
}

variable "address_space" {
  description = "The address space that is used by a Virtual Network."
  type = string
  default = "10.12.0.0/16"
}

variable "frontend_subnet_prefix" {
  description = "Address prefix to be used for network frontend subnet"
  type = string
  default = "10.12.0.0/24"
}

variable "backend_subnet_prefix" {
  description = "Address prefix to be used for network backend subnet"
  type = string
  default = "10.12.1.0/24"
}

variable "vnet_subnets" {
  description = "Subnets in vnet"
  type = list(string)
  default = ["10.12.0.0/24", "10.12.1.0/24"]
}

variable "vnet_allocation_method" {
  description = "IP address allocation method"
  type = string
  default = "Static"
}

variable "management_GUI_client_network" {
  description = "Allowed GUI clients - GUI clients network CIDR"
  type = string
}

variable "nsg_id" {
  description = "NSG ID - Optional - if empty use default NSG"
  default = ""
}

variable "add_storage_account_ip_rules" {
  type = bool
  default = false
  description = "Add Storage Account IP rules that allow access to the Serial Console only for IPs based on their geographic location"
}

variable "storage_account_additional_ips" {
  type = list(string)
  description = "IPs/CIDRs that are allowed access to the Storage Account"
  default = []
}
locals {
  regex_valid_management_GUI_client_network = "^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(/(3[0-2]|2[0-9]|1[0-9]|[0-9]))$"
  // Will fail if var.management_GUI_client_network is invalid
  regex_management_GUI_client_network = regex(local.regex_valid_management_GUI_client_network, var.management_GUI_client_network) == var.management_GUI_client_network ? 0 : "Variable [management_GUI_client_network] must be a valid IPv4 network CIDR."


  regex_valid_network_cidr = "^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(/(3[0-2]|2[0-9]|1[0-9]|[0-9]))|$"
  // Will fail if var.address_space is invalid
  regex_address_space = regex(local.regex_valid_network_cidr, var.address_space) == var.address_space ? 0 : "Variable [address_space] must be a valid address in CIDR notation."
  // Will fail if var.subnet_prefix is invalid
  regex_frontend_subnet_prefix = regex(local.regex_valid_network_cidr, var.frontend_subnet_prefix) == var.frontend_subnet_prefix ? 0 : "Variable [subnet_prefix] must be a valid address in CIDR notation."
  // Will fail if var.subnet_prefix is invalid
  regex_backend_subnet_prefix = regex(local.regex_valid_network_cidr, var.backend_subnet_prefix) == var.backend_subnet_prefix ? 0 : "Variable [subnet_prefix] must be a valid address in CIDR notation."
}

variable "bootstrap_script" {
  description = "An optional script to run on the initial boot"
  default = ""
  type = string
  #example:
  #"touch /home/admin/bootstrap.txt; echo 'hello_world' > /home/admin/bootstrap.txt"
}

//********************** Credentials **************************//

variable "sic_key" {
  type = string
}

resource "null_resource" "sic_key_invalid" {
  count = length(var.sic_key) >= 12 ? 0 : "SIC key must be at least 12 characters long"
}

variable "sku" {
  description = "SKU"
  type = string
  default = "Standard"
}

variable "security_rules" {
  description = "Security rules for the Network Security Group using this format [name, priority, direction, access, protocol, source_source_port_rangesport_range, destination_port_ranges, source_address_prefix, destination_address_prefix, description]"
  type    = list(any)
  default = [
      {
          name = "AllowAllInBound"
          priority = "100"
          direction = "Inbound"
          access = "Allow"
          protocol = "*"
          source_port_ranges = "*"
          destination_port_ranges = ""
          description = "Allow all inbound connections"
          source_address_prefix = "*"
          destination_address_prefix = ""
      }
  ]
}

variable "admin_SSH_key" {
  type = string
  description = "(Optional) The SSH public key for SSH authentication to the template instances. Leave this field blank to use all project-wide pre-configured SSH keys."
  default = ""
}