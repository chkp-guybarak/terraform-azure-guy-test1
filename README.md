# Terraform Modules for Cloudguard Security Networks - Azure

## Introduction
This repository provides a structured set of Terraform modules for deploying Check Point CloudGuard Network Security in Microsoft Azure. These modules automate the creation of high-availability architectures, virtual networks, gateways, and more, enabling secure and scalable cloud deployments.

## Repository Layout
Submodules: Contains modular, reusable, production-grade Terraform components, each with its own documentation.

Examples: Demonstrates how to use the modules together.

## Available Submodules

**Submodules**

* **high-availability-existing-vnet**
Deploys a high-availability CloudGuard setup in an existing Virtual Network.

* **high-availability-new-vnet**
Creates a new Virtual Network and deploys a high-availability CloudGuard setup.

* **management-existing-vnet**
Configures Check Point Management Servers within an existing Virtual Network.

* **management-new-vnet**
Sets up Check Point Management Servers in a newly created Virtual Network.

* **mds-existing-vnet**
Deploys Check Point Multi-Domain Servers in an existing Virtual Network.

* **mds-new-vnet**
Creates a new Virtual Network and deploys Multi-Domain Servers.

* **nva-into-existing-hub**
Integrates Network Virtual Appliances (NVAs) into an existing hub-and-spoke architecture.
 
* **nva-into-new-vwan**
Configures NVAs into a new Virtual WAN for centralized management.

* **single-gateway-existing-vnet**
Deploys a single CloudGuard gateway in an existing Virtual Network.

* **single-gateway-new-vnet**
Creates a new Virtual Network and deploys a single CloudGuard gateway.

* **vmss-existing-vnet**
Provisions Virtual Machine Scale Sets (VMSS) within an existing Virtual Network.

* **vmss-new-vnet**
Creates a new Virtual Network and deploys CloudGuard gateways using VMSS.

**Internal Submodules**

* **common**
Contains shared configurations and reusable components for all modules.

* **network-security-group**
Manages Network Security Groups (NSGs) with CloudGuard-specific rules.

* **vnet**
Simplifies Virtual Network and subnet configurations.

# Best Practices for Using Our Modules

## Step 1: Open the Terminal
Ensure you have [Azure CLI installed](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) and open the appropriate terminal based on your operating system:

---

## Step 2: Add Environment Variables
Set the required environment variables with names starting with `TF_VAR_`. Follow the instructions based on your operating system:

### Linux/macOS
<pre>
<code>
export TF_VAR_client_id="your-client-id"
export TF_VAR_client_secret="your-client-secret"
export TF_VAR_subscription_id="your-subscription-id"
export TF_VAR_tenant_id="your-tenant-id"
</code>
</pre>

### PowerShell (Windows)
<pre>
<code>
$env:TF_VAR_client_id = "your-client-id"
$env:TF_VAR_client_secret = "your-client-secret"
$env:TF_VAR_subscription_id = "your-subscription-id"
$env:TF_VAR_tenant_id = "your-tenant-id"
</code>
</pre>

### Command Prompt (Windows)
<pre>
<code>
set TF_VAR_client_id=your-client-id
set TF_VAR_client_secret=your-client-secret
set TF_VAR_subscription_id=your-subscription-id
set TF_VAR_tenant_id=your-tenant-id
</code>
</pre>

---

## Step 3: Log in with Azure CLI
Authenticate with Azure using your Service Principal credentials and the environment variables:

<pre>
<code>
az login --service-principal -u $env:TF_VAR_client_id -p $env:TF_VAR_client_secret --tenant $env:TF_VAR_tenant_id --allow-no-subscriptions
</code>
</pre>

---

## Step 4: Use the Required Module
Add the required module in your Terraform configuration file (`main.tf`) to deploy resources. For example:

<pre>
<code>
module "example_module" {
  source  = "chkp-guybarak/guy-test1/azure//modules/{module_name}"
  version = "{chosen_version}"
  # Add the required inputs
}
</code>
</pre>

---

## Step 5: Deploy with Terraform
Use Terraform commands to deploy resources securely.

### Initialize Terraform
Prepare the working directory and download required provider plugins:
<pre>
<code>
terraform init
</code>
</pre>

### Plan Deployment
Preview the changes Terraform will make:
<pre>
<code>
terraform plan
</code>
</pre>

### Apply Deployment
Apply the planned changes and deploy the resources:
<pre>
<code>
terraform apply
</code>
</pre>
When prompted, type `yes` to confirm the deployment.


## Security Rules Default Configuration
Some modules in this repository include default security rules configured for "allow all inbound traffic." These rules are provided for ease of deployment but are not intended for production use without further customization. Adding any security rule will override the default "allow all inbound traffic" configuration.

**Example:** To restrict inbound traffic, update the security_rules attribute in the network-security-group submodule configuration:
<pre>
<code>
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
</code>
</pre>

**Recommendation:** Always follow the principle of least privilege when configuring security rules to reduce exposure to threats.