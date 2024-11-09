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

4. install docker on server VM


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
    

Pipeline configuration (Jenkins)

- Jenkins Install
  1. ````./jenkins.sh````

Jenkins installation:

Install Java 17 or Java 21 (depends on your machine requirements):
OpenJDK JDK / JRE 17 - 64 bits
OpenJDK JDK / JRE 21 - 64 bits

Download and install Jenkins( Windows):

go to https://www.jenkins.io/download/#downloading-jenkins
and choose your operational system

Configure Jenkins:

Go to Manage Jenkins > Manage Credentials.

Add Docker Hub registry
Add Azure CLI 

2. Set Up the Jenkins Pipeline
In Jenkins, create a new pipeline project:

Go to Jenkins Dashboard > New Item.
Choose Pipeline, give it a name,  and select Github Project

Under General, check the GitHub Project checkbox.
Enter the GitHub repository URL (e.g., https://github.com/your-org/your-repo).

Configure Source Code Management with GitHub
To enable Jenkins to pull code from your GitHub repository, configure the Source Code Management (SCM) section.

In the Pipeline job configuration, scroll down to the Source Code Management section.
Select Git.
Enter your Repository URL (e.g., https://github.com/your-org/your-repo.git).
Add Credentials if the repository is private, selecting the GitHub credentials you added to Jenkins.
Specify the branch to build (e.g., main or */main).

Select itHub hook trigger for GITScm polling.

In the Payload URL field, enter the Jenkins webhook URL, which usually looks like this: http://your-jenkins-url/github-webhook/.
Set Content type to application/json.
Under Which events would you like to trigger this webhook?, select Just the push event to trigger the webhook only on code pushes.
Click Add webhook.











Port 8080 configuration
- Open Port 8080 in Azure VM:
1. Go to Networking under your VM settings in the Azure portal.
2. Add an inbound port rule to allow TCP traffic on port 8080.

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
  6. Click on new item  in the left menu
 

  
   





        

        
     





