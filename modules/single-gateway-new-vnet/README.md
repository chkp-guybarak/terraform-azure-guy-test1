# Check Point CloudGuard Network Security Single Gateway Terraform Registry deployment for Azure

This Terraform module deploys Check Point CloudGuard Network Security Single Gateway solution into a new Vnet in Azure.
As part of the deployment the following resources are created:
- Resource group
- Virtual network
- Network security group
- System assigned identity


This solution uses the following modules:
- /terraform/azure/modules/common - used for creating a resource group and defining common variables.
- /terraform/azure/modules/vnet - used for creating new virtual network and subnets.
- /terraform/azure/modules/network-security-group - used for creating new network security groups and rules.

## Usage
Follow best practices for using our modules on [the root page](https://registry.terraform.io/modules/chkp-guybarak/guy-test1/azure/latest).

### Module's variables:
 | Name          | Description | Type | Allowed values | Default        |
 |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------| ------------- | ------------- |----------------| ------------- |
 | **source_image_vhd_uri** | The URI of the blob containing the development image. Please use noCustomUri if you want to use marketplace images                                                                                                                                                                                                              | string | | "noCustomUri"  
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **resource_group_name** | The name of the resource group that will contain the contents of the deployment                                                                                                                                                                                                                                                 | string | Resource group names only allow alphanumeric characters, periods, underscores, hyphens and parenthesis and cannot end in a period | n/a            
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **single_gateway_name** | The name of the Check Point single GW Object                                                                                                                                                                                                                                                                                    | string | Only alphanumeric characters are allowed, and the name must be 1-30 characters long | n/a            
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **location** | The region where the resources will be deployed at                                                                                                                                                                                                                                                                              | string | The full list of Azure regions can be found at https://azure.microsoft.com/regions | n/a            
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **vnet_name** | The name of virtual network that will be created                                                                                                                                                                                                                                                                                | string | The name must begin with a letter or number, end with a letter, number or underscore, and may contain only letters, numbers, underscores, periods, or hyphens | n/a            
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **address_space** | The address prefixes of the virtual network                                                                                                                                                                                                                                                                                     | string | Valid CIDR block | "10.12.0.0/16" 
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **frontend_subnet_prefix** | The address prefix to be used for created frontend subnet                                                                                                                                                                                                                                                                       | string | The subnets need to contain within the address space for this virtual network(defined by address_space variable) | "10.12.0.0/24" 
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **backend_subnet_prefix** | The address prefix to be used for created backend subnet                                                                                                                                                                                                                                                                        | string | The subnets need to contain within the address space for this virtual network(defined by address_space variable) | "10.12.1.0/24" 
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **management_GUI_client_network** | Allowed GUI clients - GUI clients network CIDR                                                                                                                                                                                                                                                                                  | string | | n/a            
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **admin_password** | The password associated with the local administrator account on the gateway                                                                                                                                                                                                                                                     | string | Password must have 3 of the following: 1 lower case character, 1 upper case character, 1 number, and 1 special character | n/a            
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **smart_1_cloud_token** | Smart-1 Cloud token to connect automatically ***Gateway*** to Check Point's Security Management as a Service. <br/><br/> Follow these instructions to quickly connect this member to Smart-1 Cloud - [SK180501](https://supportcenter.checkpoint.com/supportcenter/portal?eventSubmit_doGoviewsolutiondetails=&solutionid=sk180501) | string | A valid token copied from the Connect Gateway screen in Smart-1 Cloud portal | n/a            
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **sic_key** | The Secure Internal Communication one time secret used to set up trust between the gateway object and the management server                                                                                                                                                                                                     | string | Only alphanumeric characters are allowed, and the value must be 12-30 characters long | n/a            
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **vm_size** | Specifies the size of Virtual Machine                                                                                                                                                                                                                                                                                           | string | "Standard_DS2_v2", "Standard_DS3_v2", "Standard_DS4_v2", "Standard_DS5_v2", "Standard_F2s", "Standard_F4s", "Standard_F8s", "Standard_F16s", "Standard_D4s_v3", "Standard_D8s_v3", "Standard_D16s_v3", "Standard_D32s_v3", "Standard_D64s_v3", "Standard_E4s_v3", "Standard_E8s_v3", "Standard_E16s_v3", "Standard_E20s_v3", "Standard_E32s_v3", "Standard_E64s_v3", "Standard_E64is_v3", "Standard_F4s_v2", "Standard_F8s_v2", "Standard_F16s_v2", "Standard_F32s_v2", "Standard_F64s_v2", "Standard_M8ms", "Standard_M16ms", "Standard_M32ms", "Standard_M64ms", "Standard_M64s", "Standard_D2_v2", "Standard_D3_v2", "Standard_D4_v2", "Standard_D5_v2", "Standard_D11_v2", "Standard_D12_v2", "Standard_D13_v2", "Standard_D14_v2", "Standard_D15_v2", "Standard_F2", "Standard_F4", "Standard_F8", "Standard_F16", "Standard_D4_v3", "Standard_D8_v3", "Standard_D16_v3", "Standard_D32_v3", "Standard_D64_v3", "Standard_E4_v3", "Standard_E8_v3", "Standard_E16_v3", "Standard_E20_v3", "Standard_E32_v3", "Standard_E64_v3", "Standard_E64i_v3", "Standard_DS11_v2", "Standard_DS12_v2", "Standard_DS13_v2", "Standard_DS14_v2", "Standard_DS15_v2", "Standard_D2_v5", "Standard_D4_v5", "Standard_D8_v5", "Standard_D16_v5","Standard_D32_v5", "Standard_D2s_v5", "Standard_D4s_v5", "Standard_D8s_v5", "Standard_D16s_v5", "Standard_D2d_v5", "Standard_D4d_v5", "Standard_D8d_v5", "Standard_D16d_v5", "Standard_D32d_v5", "Standard_D2ds_v5", "Standard_D4ds_v5", "Standard_D8ds_v5", "Standard_D16ds_v5", "Standard_D32ds_v5" | n/a            
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **disk_size** | Storage data disk size size(GB)                                                                                                                                                                                                                                                                                                 | string | A number in the range 100 - 3995 (GB) | n/a            
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **vm_os_sku** | A sku of the image to be deployed                                                                                                                                                                                                                                                                                               | string |  "sg-byol" - BYOL license; <br/>"sg-ngtp" - NGTP PAYG license; <br/>"sg-ngtx" - NGTX PAYG license | n/a            
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **vm_os_offer** | The name of the image offer to be deployed                                                                                                                                                                                                                                                                                      | string | "check-point-cg-r81"; <br/>"check-point-cg-r8110"; <br/>"check-point-cg-r8120"; <br/>"check-point-cg-r82"; | n/a            
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **os_version** | GAIA OS version                                                                                                                                                                                                                                                                                                                 | string | "R81"; <br/>"R8110"; <br/>"R8120"; <br/>"R82"; | n/a |
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **bootstrap_script** | An optional script to run on the initial boot                                                                                                                                                                                                                                                                                   | string | Bootstrap script example: <br/>"touch /home/admin/bootstrap.txt; echo 'hello_world' > /home/admin/bootstrap.txt" <br/>The script will create bootstrap.txt file in the /home/admin/ and add 'hello word' string into it | ""             
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **allow_upload_download** | Automatically download Blade Contracts and other important data. Improve product experience by sending data to Check Point                                                                                                                                                                                                      | boolean | true; <br/>false; | n/a            
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **authentication_type** | Specifies whether a password authentication or SSH Public Key authentication should be used                                                                                                                                                                                                                                     | string | "Password"; <br/>"SSH Public Key"; | n/a            
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **enable_custom_metrics** | Indicates whether CloudGuard Metrics will be use for gateway monitoring                                                                                                                                                                                                                                                         | boolean | true; <br/>false; | true           
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **admin_shell** | Enables to select different admin shells                                                                                                                                                                                                                                                                                        | string | /etc/cli.sh; <br/>/bin/bash; <br/>/bin/csh; <br/>/bin/tcsh; | "/etc/cli.sh"  
 |  |                                                                                                                                                                                                                                                                                                                                 |  |  |                |
 | **installation_type** | Enables to select installation type- gateway/standalone                                                                                                                                                                                                                                                                         | string | gateway; <br/>standalone; | n/a            | string | gateway; <br/>standalone; |
 |  |  |  |  |                |
 | **serial_console_password_hash** | Optional parameter, used to enable serial console connection in case of SSH key as authentication type, to generate password hash use the command 'openssl passwd -6 PASSWORD' on Linux and paste it here  | string | | n/a            
 |  |  |  |  |                |
 | **maintenance_mode_password_hash** | Maintenance mode password hash, relevant only for R81.20 and higher versions, to generate a password hash use the command 'grub2-mkpasswd-pbkdf2' on Linux and paste it here  | string | | n/a            
 |  |  |  |  |                |
 | **nsg_id** | Optional ID for a Network Security Group that already exists in Azure, if isn't provided will create a default NSG | string | Existing NSG resource ID | ""             
 |  |  |  |  |  |
 | **add_storage_account_ip_rules** | Add Storage Account IP rules that allow access to the Serial Console only for IPs based on their geographic location, if false then accses will be allowed from all networks | boolean | true; <br/>false; |  false
 |  |  |  |  |  |
 | **storage_account_additional_ips** | IPs/CIDRs that are allowed access to the Storage Account | list(string) | A list of valid IPs and CIDRs | []

## Conditional creation
-  To enable CloudGuard metrics in order to send statuses and statistics collected from the gateway instance to the Azure Monitor service:
  ```
  enable_custom_metrics = true
  ```

## Example
```hcl
provider "azurerm" {
  features {}
}

# Main Module Invocation
module "single_gateway_new_vnet" {
  source  = "chkp-guybarak/guy-test1/azure//modules/single-gateway-new-vnet"
  version = "1.0.5"
  
  # Basic Configuration
  single_gateway_name          = "checkpoint-single-gw-terraform"
  resource_group_name          = "checkpoint-single-gw-terraform"
  location                     = "East US"
  admin_password               = "YourSecurePassword123!"
  template_name                = "single"
  template_version             = "20240613"
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
  security_rules = [
    {
      name                       = "allowJenkins"
      priority                   = "100"
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_ranges         = "*"
      destination_port_ranges    = "*"
      description                = "allow jenkins"
      source_address_prefix      = "54.220.66.248/32"
      destination_address_prefix = "74.235.20.103/32"
    }
  ]

  # Networking
  vnet_name            = "checkpoint-single-gw-vnet"
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
  sic_key                       = "xxxxxxxxxxxx"
  smart_1_cloud_token           = "your-smart-1-cloud-token"
}
```

## Revision History
In order to check the template version refer to the [sk116585](https://supportcenter.checkpoint.com/supportcenter/portal?eventSubmit_doGoviewsolutiondetails=&solutionid=sk116585)

| Template Version | Description                                                                                       |
|------------------|---------------------------------------------------------------------------------------------------|
| 20230910 | - R81.20 is the default version |
| | | |
| 20230629         | First release of Check Point CloudGuard Network Security Single GW Terraform deployment for Azure |
|                  |                                                                                                   | |


## License

See the [LICENSE](../../LICENSE) file for details

