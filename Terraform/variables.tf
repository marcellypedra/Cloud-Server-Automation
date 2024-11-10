variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = "70840eef-81ee-40d0-bda2-421217416697"
}

variable "location" {
  description = "Azure location"
  type        = string
  default     ="westeurope"
}

variable "private_ip" {
  description = "Static private IP for NIC"
  type        = string
  default     = "10.1.0.4"  
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "MP20040674"

}
variable "public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     ="/home/MP20040674/.ssh/id_ed25519.pub"
}

variable "private_key_path" {
  description = "Path to SSH private key"
  type        = string
  default     ="/home/MP20040674/.ssh/id_ed25519"
}