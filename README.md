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


## Clone this repository:
   ```git clone https://github.com/marcellypedra/Cloud-Server-Automation.git```   
   ```cd Cloud-Server-Automation/Terraform```
   
   ### Make the script executable by giving it the correct permissions. 
      chmod +x terraform.sh docker.sh ansible.sh jenkins.sh

      ## Initial Installation
1. ```./initial_installation.sh```
  
2. Access by URL and code to authenticate   
      ```https://microsoft.com/devicelogin ```

   - Terraform install and verify
      1. ```./terraform.sh```   
      
   - Ansible and Docker install and verify
      1. ```./ansible.sh```   
     

   - Docker create an image, push container and verify
      1. ```./docker.sh```
    
Preparing environment for Jenkins

Port 8080 configuration
- Open Port 8080 in Azure VM:
1. Go to Networking under your VM settings in the Azure portal.
2. Add an inbound port rule to allow TCP traffic on port 8080.
Pipeline configuration (Jenkins)

- Jenkins Install
  1. ````./jenkins.sh````


- Access Jenkins Web Interface
1. In your browser, go to http://your-vm-ip-address:8080.
2. You should see the Jenkins setup page.

- Complete Setup
  1. Go back to the terminal and find the initial admin password:
   ````sudo cat /var/lib/jenkins/secrets/initialAdminPassword````
  2. Copy the password and paste it into the Jenkins setup page.
  3. Install Docker plugin, Github plugin, Azure CLI plugin and SSH plugin
  4. create an admin user
  5. Complete setup

- Github Webhook configuration
1. Go to your Github Repository settings 
2. On the left panel, choose "Webooks"
3. "Add webhook" on the top-right
4. In the Payload URL field, enter the Jenkins webhook URL, which usually looks like this: http://your-jenkins-url/github-webhook/
5. Set Content type to "application/json"
6. Under Which events would you like to trigger this webhook?, select "Just the push event to trigger the webhook only on code pushes."
7. Click "Add webhook".

- Add SSH Key to Jenkins Credentials
 1. Go to Jenkins Dashboard > Manage Jenkins > Manage Credentials.
 2. Under Global credentials, click Add Credentials.

  a. Kind: SSH Username with private key.
  b. Username: Enter the SSH user for the Azure VM (e.g., azureuser).
  c.Private Key: Choose Enter directly and paste the contents of your private SSH key (id_rsa).
  d. ID: Give it an ID like azure-ssh.


- Set Up the Jenkins Pipeline
In Jenkins, create a new pipeline project:

1. Go to Jenkins Dashboard > New Item.
Choose Pipeline, give it a name,  and select Github Project

2. Under General, check the GitHub Project checkbox.
Enter the GitHub repository URL (e.g., https://github.com/your-org/your-repo).

3. To enable Jenkins to pull code from your GitHub repository, configure the Source Code Management (SCM) section.

4. In the Pipeline job configuration, scroll down to the Source Code Management section.
Select Git.
Enter your Repository URL (e.g., https://github.com/your-org/your-repo.git).

5. Add Credentials if the repository is private, selecting the GitHub credentials you added to Jenkins.
Specify the branch to build (e.g., main or */main).

6. Select itHub hook trigger for GITScm polling.



















Click on new item  in the left menu
 

  
   





        

        
     





