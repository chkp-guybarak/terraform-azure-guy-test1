# Check Point CloudGuard Management Module - New  VNet 

This Terraform module deploys Check Point CloudGuard Network Security Management solution into a new  VNet in Azure.
As part of the deployment the following resources are created:
- Resource group
- Virtual network
- Network security group
- Virtual Machine
- System assigned identity

This solution uses the following modules:
- /terraform/azure/modules/common - used for creating a resource group and defining common variables.
- /terraform/azure/modules/  VNet - used for creating new virtual network and subnets.
- /terraform/azure/modules/network_security_group - used for creating new network security groups and rules.


### terraform.tfvars variables:
 | Name          | Description   | Type          | Allowed values | Default |
 | ------------- | ------------- | ------------- | -------------  | -------------  |
 | **client_secret** | The client secret of the Service Principal used to deploy the solution | string | | n/a
 |  |  |  |  |  |
 | **client_id** | The client ID of the Service Principal used to deploy the solution | string | | n/a
 |  |  |  |  |  |
 | **tenant_id** | The tenant ID of the Service Principal used to deploy the solution | string | | n/a
 |  |  |  |  |  |
 | **subscription_id** | The subscription ID is used to pay for Azure cloud services | string | | n/a
 |  |  |  |  |  |
 | **source_image_vhd_uri** | The URI of the blob containing the development image. Please use noCustomUri if you want to use marketplace images  | string | | "noCustomUri"
 |  |  |  |  |  |
 | **resource_group_name** | The name of the resource group that will contain the contents of the deployment | string | Resource group names only allow alphanumeric characters, periods, underscores, hyphens and parenthesis and cannot end in a period | n/a
 |  |  |  |  |  |
 | **mgmt_name** | Management name  | string | | n/a 
 |  |  |  |  |  |
 | **location** | The region where the resources will be deployed at  | string | The full list of Azure regions can be found at https://azure.microsoft.com/regions | n/a
 |  |  |  |  |  |
 | ** VNet_name** | The name of virtual network that will be created  | string | The name must begin with a letter or number, end with a letter, number or underscore, and may contain only letters, numbers, underscores, periods, or hyphens | n/a
 |  |  |  |  |  |
 | **address_space** | The address space that is used by a Virtual Network  | string | A valid address in CIDR notation  | "10.0.0.0/16"
 |  |  |  |  |  |
 | **subnet_prefix** | Address prefix to be used for network subnet | string | A valid address in CIDR notation  | "10.0.0.0/24"
 |  |  |  |  |  |
 | **management_GUI_client_network** | Allowed GUI clients - GUI clients network CIDR  | string | | n/a
 |  |  |  |  |  |
 | **mgmt_enable_api** | Enable api access to the management  | string | - "all"; <br/> - "management_only"; <br/> - "gui_clients" <br/> - "disable"; | "disable"
 |  |  |  |  |  |
 | **admin_password** | The password associated with the local administrator account on each cluster member | string | Password must have 3 of the following: 1 lower case character, 1 upper case character, 1 number, and 1 special character | n/a
 |  |  |  |  |  |
 | **vm_size** | Specifies the size of Virtual Machine | string | "Standard_DS2_v2", "Standard_DS3_v2", "Standard_DS4_v2", "Standard_DS5_v2", "Standard_F2s", "Standard_F4s", "Standard_F8s", "Standard_F16s", "Standard_D4s_v3", "Standard_D8s_v3", "Standard_D16s_v3", "Standard_D32s_v3", "Standard_D64s_v3", "Standard_E4s_v3", "Standard_E8s_v3", "Standard_E16s_v3", "Standard_E20s_v3", "Standard_E32s_v3", "Standard_E64s_v3", "Standard_E64is_v3", "Standard_F4s_v2", "Standard_F8s_v2", "Standard_F16s_v2", "Standard_F32s_v2", "Standard_F64s_v2", "Standard_M8ms", "Standard_M16ms", "Standard_M32ms", "Standard_M64ms", "Standard_M64s", "Standard_D2_v2", "Standard_D3_v2", "Standard_D4_v2", "Standard_D5_v2", "Standard_D11_v2", "Standard_D12_v2", "Standard_D13_v2", "Standard_D14_v2", "Standard_D15_v2", "Standard_F2", "Standard_F4", "Standard_F8", "Standard_F16", "Standard_D4_v3", "Standard_D8_v3", "Standard_D16_v3", "Standard_D32_v3", "Standard_D64_v3", "Standard_E4_v3", "Standard_E8_v3", "Standard_E16_v3", "Standard_E20_v3", "Standard_E32_v3", "Standard_E64_v3", "Standard_E64i_v3", "Standard_DS11_v2", "Standard_DS12_v2", "Standard_DS13_v2", "Standard_DS14_v2", "Standard_DS15_v2", "Standard_D2_v5", "Standard_D4_v5", "Standard_D8_v5", "Standard_D16_v5","Standard_D32_v5", "Standard_D2s_v5", "Standard_D4s_v5", "Standard_D8s_v5", "Standard_D16s_v5", "Standard_D2d_v5", "Standard_D4d_v5", "Standard_D8d_v5", "Standard_D16d_v5", "Standard_D32d_v5", "Standard_D2ds_v5", "Standard_D4ds_v5", "Standard_D8ds_v5", "Standard_D16ds_v5", "Standard_D32ds_v5" | n/a
 |  |  |  |  |  |
 | **disk_size** | Storage data disk size size(GB) | string | A number in the range 100 - 3995 (GB) | n/a
 |  |  |  |  |  |
 | **vm_os_sku** | A sku of the image to be deployed | string |  "mgmt-byol" - BYOL license; <br/>"mgmt-25" - PAYG; | n/a
 |  |  |  |  |  |
 | **vm_os_offer** | The name of the image offer to be deployed | string | "check-point-cg-r81"; <br/>"check-point-cg-r8110"; <br/>"check-point-cg-r8120"; <br/>"check-point-cg-r82"; | n/a
 |  |  |  |  |  |
 | **os_version** | GAIA OS version | string | "R81"; <br/>"R8110"; <br/>"R8120"; <br/>"R82"; | n/a
 |  |  |  |  |  |
 | **bootstrap_script** | An optional script to run on the initial boot | string | Bootstrap script example: <br/>"touch /home/admin/bootstrap.txt; echo 'hello_world' > /home/admin/bootstrap.txt" <br/>The script will create bootstrap.txt file in the /home/admin/ and add 'hello word' string into it | ""
 |  |  |  |  |  |
 | **allow_upload_download** | Automatically download Blade Contracts and other important data. Improve product experience by sending data to Check Point | boolean | true; <br/>false; | n/a
 |  |  |  |  |  |
 | **authentication_type** | Specifies whether a password authentication or SSH Public Key authentication should be used | string | "Password"; <br/>"SSH Public Key"; | n/a
 |  |  |  |  |  |
 | **admin_shell** | Enables to select different admin shells | string | /etc/cli.sh; <br/>/bin/bash; <br/>/bin/csh; <br/>/bin/tcsh; | "/etc/cli.sh"
 |  |  |  |  |  |
 | **serial_console_password_hash** | Optional parameter, used to enable serial console connection in case of SSH key as authentication type, to generate password hash use the command 'openssl passwd -6 PASSWORD' on Linux and paste it here  | string | | n/a
 |  |  |  |  |  |
 | **maintenance_mode_password_hash** | Maintenance mode password hash, relevant only for R81.20 and higher versions, to generate a password hash use the command 'grub2-mkpasswd-pbkdf2' on Linux and paste it here  | string |  | n/a
 |  |  |  |  |  |
 | **nsg_id** | Optional ID for a Network Security Group that already exists in Azure, if not provided, will create a default NSG | string | Existing NSG resource ID | "" 
 |  |  |  |  |  |
 | **add_storage_account_ip_rules** | Add Storage Account IP rules that allow access to the Serial Console only for IPs based on their geographic location, if false then accses will be allowed from all networks | boolean | true; <br/>false; |  false
 |  |  |  |  |  |
 | **storage_account_additional_ips** | IPs/CIDRs that are allowed access to the Storage Account | list(string) | A list of valid IPs and CIDRs | []


## Example
    client_secret                   = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    client_id                       = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    tenant_id                       = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    subscription_id                 = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    source_image_vhd_uri            = "noCustomUri"
    resource_group_name             = "checkpoint-mgmt-terraform"
    mgmt_name                       = "checkpoint-mgmt-terraform"
    location                        = "eastus"
     VNet_name                       = "checkpoint-mgmt- VNet"
    address_space                   = "10.0.0.0/16"
    subnet_prefix                   = "10.0.0.0/24"
    management_GUI_client_network   = "0.0.0.0/0"
    mgmt_enable_api                 = "disable"
    admin_password                  = "xxxxxxxxxxxx"
    vm_size                         = "Standard_D3_v2"
    disk_size                       = "110"
    vm_os_sku                       = "mgmt-byol"
    vm_os_offer                     = "check-point-cg-r8110"
    os_version                      = "R8110"
    bootstrap_script                = "touch /home/admin/bootstrap.txt; echo 'hello_world' > /home/admin/bootstrap.txt"
    allow_upload_download           = true
    authentication_type             = "Password"
    admin_shell                     = "/etc/cli.sh"
    serial_console_password_hash    = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    maintenance_mode_password_hash  = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    nsg_id                          = ""
    add_storage_account_ip_rules    = false
    storage_account_additional_ips  = []

## Revision History
In order to check the template version refer to the [sk116585](https://supportcenter.checkpoint.com/supportcenter/portal?eventSubmit_doGoviewsolutiondetails=&solutionid=sk116585)

| Template Version | Description   |
| ---------------- | ------------- |
| 20240613 | - Updated Azure Terraform provider version <br> - Cosmetic fixes & default values <br> - Added option to limit storage account access by specify allowed sourcess <br> - Updated Public IP sku to Standard <br> - Added validation for os_version & os_offer |
| | | |     
| 20230910 | - R81.20 is the default version |
| | | |
| 20221124 | - Added R81.20 support   <br/> - Upgraded azurerm provider |
| | | |
| 20220111 | - Added support to select different shells  |
| | | |
| 20210309 | - Add "source_image_vhd_uri" variable for using a custom development image |
| | | |
| 20210111 | First release of Check Point CloudGuard IaaS Management Terraform deployment into a new  VNet in Azure  |
| | | |
|  | Addition of "templateType" parameter to "cloud-version" files  |
| | | |

## License

See the [LICENSE](../../LICENSE) file for details

