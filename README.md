# Terraform Modules for Cloudguard Security Networks - Azure

![GitHub Release](https://img.shields.io/github/v/release/chkp-guybarak/terraform-azure-guy-test1)
![GitHub watchers](https://img.shields.io/github/watchers/chkp-guybarak/terraform-azure-guy-test1)

## Introduction
This repository provides a structured set of Terraform modules for deploying Check Point CloudGuard Network Security in Microsoft Azure. These modules automate the creation of high-availability architectures, virtual networks, gateways, and more, enabling secure and scalable cloud deployments.

## Repository Layout
Submodules: Contains modular, reusable, production-grade Terraform components, each with its own documentation.

Examples: Demonstrates how to use the modules together.

## Available Submodules

**Submodules**

* **High-availability-existing-vnet -** 
Deploys Check Point CloudGuard IaaS High Availability solution into an existing Vnet in Azure.

* **High-availability-new-vnet**
Deploys Check Point CloudGuard IaaS High Availability solution into a new Vnet.

* **Management-existing-vnet -** Deploys Check Point CloudGuard IaaS Management solution into an existing Vnet.

* **Management-new-vnet -** Deploys Check Point CloudGuard IaaS Management solution into a new Vnet.

* **Mds-existing-vnet -** Deploys Check Point CloudGuard Network Security Management solution into a new Vnet.

* **Mds-new-vnet -** Deploys Check Point CloudGuard Network Security Management solution into a new Vnet.

* **Nva-into-existing-hub* -** Deploys Check Point CloudGuard Network Security Virtual WAN NVA solution into an existing vWAN Hub.

* **Nva-into-new-vwan -** Deploys CloudGuard Network Security Virtual WAN NVA solution into a new vWAN Hub.

* **Single-gateway-existing-vnet -** Deploys Check Point CloudGuard Network Security Single Gateway solution into an existing Vnet.

* **Single-gateway-new-vnet -** Deploys Check Point CloudGuard Network Security Single Gateway solution into a new Vnet.

* **Vmss-existing-vnet -** Deploys Check Point CloudGuard IaaS VMSS solution into an existing Vnet.

* **Vmss-new-vnet -** Deploys Check Point CloudGuard IaaS VMSS solution into a new Vnet.

**Internal Submodules -** Deploys

* **Common -** Contains shared configurations and reusable components for all modules.

* **Network-security-group -** Manages Network Security Groups (NSGs) with CloudGuard-specific rules.

* **Vnet -** Simplifies Virtual Network and subnet configurations.



## Security Rules Default Configuration
Some modules in this repository include default security rules configured for "allow all inbound traffic." These rules are provided for ease of deployment but are not intended for production use without further customization. Add security rule to override the default "allow all traffic" configuration.

**Example:** To restrict inbound traffic, update the security_rules attribute in the network-security-group submodule configuration:
```hcl
security_rules = [
  {
    name                       = "AllowSSH"
    priority                   = "100"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_ranges         = "*"
    destination_port_ranges    = "22"
    description                = "Allow SSH inbound connections"
    source_address_prefix      = "10.0.0.0/8"
    destination_address_prefix = "*"
  }
]
```

**Recommendation:** Always follow the principle of least privilege when configuring security rules to reduce exposure to threats.

# Best Practices for Using Our Modules

## Step 1: Use the Required Module
Add the required module in your Terraform configuration file (`main.tf`) to deploy resources. For example:

```hcl
provider "azurerm" {
  features {}
}

module "example_module" {
  source  = "chkp-guybarak/guy-test1/azure//modules/{module_name}"
  version = "{chosen_version}"
  # Add the required inputs
}
```
---

## Step 2: Open the Terminal
Ensure you have [Azure CLI installed](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) and navigate to the directory where your `main.tf` file is located, using the appropriate terminal: 

- **Linux/macOS**: **Terminal**.
- **Windows**: **PowerShell** or **Command Prompt**.
---

## Step 3: Set Environment Variables and Log in with Azure CLI
Set the required environment variables and authenticate with Azure using your Service Principal. Then, select the correct subscription.

### Linux/macOS
```hcl
export TF_VAR_client_id="{your-client-id}"
export TF_VAR_client_secret="{your-client-secret}"
export TF_VAR_subscription_id="{your-subscription-id}"
export TF_VAR_tenant_id="{your-tenant-id}"

az login --service-principal -u $TF_VAR_client_id -p $TF_VAR_client_secret --tenant $TF_VAR_tenant_id
az account set --subscription $TF_VAR_subscription_id
```
### PowerShell (Windows)
```hcl
$env:TF_VAR_client_id="{your-client-id}"
$env:TF_VAR_client_secret="{your-client-secret}"
$env:TF_VAR_subscription_id="{your-subscription-id}"
$env:TF_VAR_tenant_id="{your-tenant-id}"

az login --service-principal -u $env:TF_VAR_client_id -p $env:TF_VAR_client_secret --tenant $env:TF_VAR_tenant_id
az account set --subscription $env:TF_VAR_subscription_id
```
### Command Prompt (Windows)
```hcl
set TF_VAR_client_id="{your-client-id}"
set TF_VAR_client_secret="{your-client-secret}"
set TF_VAR_subscription_id="{your-subscription-id}"
set TF_VAR_tenant_id="{your-tenant-id}"

az login --service-principal -u %TF_VAR_client_id% -p %TF_VAR_client_secret% --tenant %TF_VAR_tenant_id%
az account set --subscription %TF_VAR_subscription_id%
```
---


## Step 4: Deploy with Terraform
Use Terraform commands to deploy resources securely.

### Initialize Terraform
Prepare the working directory and download required provider plugins:
```hcl
terraform init
```

### Plan Deployment
Preview the changes Terraform will make:
```hcl
terraform plan
```
### Apply Deployment
Apply the planned changes and deploy the resources:
```hcl
terraform apply
```
