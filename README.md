# Cloud
# Infrastructure Setup

This repository contains scripts to install Terraform, Ansible, and Docker on your VM Azure.

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
      chmod +x terraform_install.sh docker_install.sh ansible_install.sh 

   - Terraform install and verify
      1. ```./terraform_install.sh```   
      2. ```terraform --version```   
      3. ```terraform init```   
      4.   ```terraform validate```
      5. ```terraform plan```   
      6. ```terraform apply```
   - Docker install and verify
      1. ```./docker_install.sh```   
      2. ```docker --version```
   - Ansible install and verify 
      1. ```./ansible_install.sh```   
      2. ```ansible --version```   
   - Docker push container -> in progress
      1. ```???```  
      2. ```???```   
      3. ```???```   
     
