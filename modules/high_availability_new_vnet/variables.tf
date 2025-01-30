//********************** Basic Configuration Variables **************************//
variable "tenant_id" {
  description = "Tenant ID"
  type = string
}

variable "cluster_name" {
  description = "Cluster name"
  type = string
}

variable "resource_group_name" {
  description = "Azure Resource Group name to build into"
  type = string
}

variable "location" {
  description = "The location/region where resources will be created. The full list of Azure regions can be found at https://azure.microsoft.com/regions"
  type = string
}

//********************** Virtual Machine Instances Variables **************************//
variable "availability_type" {
  description = "Specifies whether to deploy the solution based on Azure Availability Set or based on Azure Availability Zone."
  type = string
  default = "Availability Zone"
}

locals { // locals for 'availability_type' allowed values
  availability_type_allowed_values = [
    "Availability Zone",
    "Availability Set"
  ]
  // will fail if [var.availability_type] is invalid:
  validate_availability_type_value = index(local.availability_type_allowed_values, var.availability_type)
}

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
  description = "Administrator password of deployed Virtual Macine. The password must meet the complexity requirements of Azure"
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

variable "smart_1_cloud_token_a" {
  description = "Smart-1 Cloud Token, for configuring member A"
  type = string
}

variable "smart_1_cloud_token_b" {
  description = "Smart-1 Cloud Token, for configuring member B"
  type = string
}

variable "sic_key" {
  description = "Secure Internal Communication(SIC) key"
  type = string
}
resource "null_resource" "sic_key_invalid" {
  count = length(var.sic_key) >= 12 ? 0 : "SIC key must be at least 12 characters long"
}

variable "installation_type" {
  description = "Installaiton type"
  type = string
  default = "cluster"
}

variable "number_of_vm_instances" {
  description = "Number of VM instances to deploy "
  type = string
  default = "2"
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
  description = "The name of the image offer to be deployed.Choose from: check-point-cg-r8110, check-point-cg-r8120, check-point-cg-r82"
  type = string
}

locals { // locals for 'vm_os_offer' allowed values
  vm_os_offer_allowed_values = [
    "check-point-cg-r8110",
    "check-point-cg-r8120",
    "check-point-cg-r82"
  ]
  // will fail if [var.vm_os_offer] is invalid:
  validate_os_offer_value = index(local.vm_os_offer_allowed_values, var.vm_os_offer)
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

variable "allow_upload_download" {
  description = "Automatically download Blade Contracts and other important data. Improve product experience by sending data to Check Point"
  type = bool
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

//********************** Natworking Variables **************************//
variable "vnet_name" {
  description = "Virtual Network name"
  type = string
}

variable "address_space" {
  description = "The address space that is used by a Virtual Network."
  type = string
  default = "10.0.0.0/16"
}

variable "subnet_prefixes" {
  description = "Address prefix to be used for netwok subnets"
  type = list(string)
  default = [
    "10.0.0.0/24",
    "10.0.1.0/24"]
}

variable "lb_probe_name" {
  description = "Name to be used for lb health probe"
  default = "health_prob_port"
}

variable "lb_probe_port" {
  description = "Port to be used for load balancer health probes and rules"
  default = "8117"
}

variable "lb_probe_protocol" {
  description = "Protocols to be used for load balancer health probes and rules"
  default = "Tcp"
}

variable "lb_probe_unhealthy_threshold" {
  description = "Number of times load balancer health probe has an unsuccessful attempt before considering the endpoint unhealthy."
  default = 2
}

variable "lb_probe_interval" {
  description = "Interval in seconds load balancer health probe rule perfoms a check"
  default = 5
}

variable "bootstrap_script" {
  description = "An optional script to run on the initial boot"
  #example:
  #"touch /home/admin/bootstrap.txt; echo 'hello_world' > /home/admin/bootstrap.txt"
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

variable "sku" {
  description = "SKU"
  type = string
  default = "Standard"
}

variable "enable_custom_metrics" {
  description = "Indicates whether CloudGuard Metrics will be use for Cluster members monitoring."
  type = bool
  default = true
}

variable "enable_floating_ip" {
  description = "Indicates whether the load balancers will be deployed with floating IP."
  type = bool
  default = false
}

variable "use_public_ip_prefix" {
  description = "Indicates whether the public IP resources will be deployed with public IP prefix."
  type = bool
  default = false
}

variable "create_public_ip_prefix" {
  description = "Indicates whether the public IP prefix will created or an existing will be used."
  type = bool
  default = false
}

variable "existing_public_ip_prefix_id" {
  description = "The existing public IP prefix resource id."
  type = string
  default = ""
}

locals{
  # Validate both s1c tokens are used or both empty
  is_both_tokens_used = length(var.smart_1_cloud_token_a) > 0 == length(var.smart_1_cloud_token_b) > 0
  validation_message_both = "To connect to Smart-1 Cloud, you must provide two tokens (one per member)"
  _ = regex("^$", (local.is_both_tokens_used ? "" : local.validation_message_both))

  is_tokens_used = length(var.smart_1_cloud_token_a) > 0
  # Validate both s1c tokens are unqiue
  token_parts_a = split(" ",var.smart_1_cloud_token_a)
  token_parts_b = split(" ",var.smart_1_cloud_token_b)
  acutal_token_a = local.token_parts_a[length(local.token_parts_a) - 1]
  acutal_token_b = local.token_parts_b[length(local.token_parts_b) - 1]
  is_both_tokens_the_same = local.acutal_token_a == local.acutal_token_b
  validation_message_unique = "Same Smart-1 Cloud token used for both memeber, you must provide unique token for each member"
  __ = local.is_tokens_used ? regex("^$", (local.is_both_tokens_the_same ? local.validation_message_unique : "")) : ""
}

variable "admin_SSH_key" {
  type = string
  description = "(Optional) TheUsed when the authentication_type is 'SSH Public Key'. The SSH public key for SSH authentication to the template instances."
  default = ""
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
      destination_port_ranges = "*"
      description = "Allow all inbound connections"
      source_address_prefix = "*"
      destination_address_prefix = "*"
    }
  ]
}
