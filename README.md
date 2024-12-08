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