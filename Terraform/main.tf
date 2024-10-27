terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "azurerm" {
  features {}
  subscription_id = "70840eef-81ee-40d0-bda2-421217416697"
}

# Declare Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "cloud_client-rg"
  location = "westeurope"
}

# Declare Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "cloud_client-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Declare Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "cloud_client-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.0.0/24"]
}

# Declare Network Security Group with Fixed Protocol
resource "azurerm_network_security_group" "nsg" {
  name                = "cloud_client-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 320
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTPS"
    priority                   = 340
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Declare Public IP
resource "azurerm_public_ip" "public_ip" {
  name                = "cloud_client-public_ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku 				  = "Standard"
}

# Declare Network Interface
resource "azurerm_network_interface" "nic" {
  name                = "cloud_client-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "cloud_client-nic-config"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.1.0.4"  
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

# Declare Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "cloud_client-vm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  size               = "Standard_B1s"
  admin_username     = "MP20040674"
  
   # Configure SSH key for access
  admin_ssh_key {
    username   = "MP20040674"  # Should match admin_username
    public_key = file("~/.ssh/id_ed25519.pub")  # Path to your public SSH key file
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "ubuntu-pro"
    version   = "latest"
  }

  computer_name  = "Cloud Client"
  disable_password_authentication = true
}

# Associate NSG with Subnet
resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
  
}
