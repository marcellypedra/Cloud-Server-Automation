# Cloud
# Infrastructure Setup

This repository contains scripts to install Terraform, Ansible, and Docker on your VM Azure.

#Prepare Environment

1. Create VM Linux as a Server using Azure (https://learn.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-portal)
2. Access your VM trhough your local terminal using SSH

WSL | PowerShell | Command Prompt
shh your_user@ServerVM_public_ip or shh your_user@ServerVM_DNS

3. Create an SSH Key for the Server VM
ssh-keygen


## Initial Installation
   1. Install Azure CLI   
      ```curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash```
   2. Login   
      ```az login```
   3. Access by URL and code to authenticate   
      ```https://microsoft.com/devicelogin ```
   4. Update Package List   
      ```sudo apt update && sudo apt upgrade -y```
      
## Clone this repository:
   ```git clone https://github.com/marcellypedra/Cloud-Server-Automation.git```   
   ```cd Cloud-Server-Automation/Terraform```
   
   ### Make the script executable by giving it the correct permissions. 
      chmod +x terraform.sh docker.sh ansible.sh 

   - Terraform install and verify
      1. ```./terraform.sh```   
      
   - Ansible and Docker install and verify
      1. ```./ansible.sh```   
     

   - Docker create an image, push container and verify
      1. ```./docker.sh``` 
        

        
     





