# Cloud-Server-Automation

Demo Videos and Presentation

````https://mydbs-my.sharepoint.com/:f:/g/personal/20040674_mydbs_ie/EiD0kHqutxtDkQ2gC0PdvfoB4CA8VZWEKrNBA8ecL99K9A?e=ZkJpBD````

This repository was created to meet the requirements for Network Systems and Admnistration CAOne (ModuleCode:B9IS121). It contains scripts to Automate a Container Deployment and Admnistration on Cloud.

It gives instructions on how to deploy a Cloud Insfrastructure to host a Server and deploy one Docker Container.

All the configurations were made using Linux in Azure VMs.  


# Prepare Environment

1. Create Linux VM as a Server using Azure (https://learn.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-portal)

2. Configure Port 8080 in you Server-VM
- Go to Networking under your VM settings in the Azure portal.
- Add an inbound port rule (name: Jenkins) to allow TCP traffic on port 8080. 

3. Access your Server VM trhough your local terminal using SSH

WSL | PowerShell | Command Prompt
shh your_user@ServerVM_public_ip or shh your_user@ServerVM_DNS

## Initial Installation

1. ```./initial_installation.sh```
  
2. Access by URL and code to authenticate   
      ```https://microsoft.com/devicelogin ```

3. Create an SSH Key for the CloudServer VM
ssh-keygen



## Clone this repository:
   ```git clone https://github.com/marcellypedra/Cloud-Server-Automation.git``` 

   ### Make the script executable by giving it the correct permissions. 
      chmod +x terraform.sh docker.sh ansible.sh jenkins.sh

```cd Cloud-Server-Automation/Terraform```
   ### Make the script executable by giving it the correct permissions.
   chmod +x terraform.sh


# Infrastructure Setup (ClientServer)

   - Terraform install and verify
      1. ```./terraform.sh```  

 
# Configuration Management   
   - Ansible and Docker install and verify
      1. ```./ansible.sh```   
     
# Docker Container Deployment
   - Docker create an image, push container and verify
      1. ```./docker.sh```

# CI/CD Pipeline Integration    
   - Jenkins Install
   1. ````./jenkins.sh````


 # Configuring Pipeline

1. Access Jenkins Web Interface
 a. In your browser, go to http://your-server-vm-ip-address:8080.
 b. You should see the Jenkins setup page.

2. Complete Setup
  a. Go back to the terminal and find the initial admin password:
   ````sudo cat /var/lib/jenkins/secrets/initialAdminPassword````
  b. Copy the password and paste it into the Jenkins setup page.
  c. Install Docker plugin, Github plugin, Azure CLI plugin, Credentials Plugin and SSH Agent Plugin
  d. create an admin user
  e. Complete setup

#  Github Webhook configuration

1. Go to your Github Repository settings 
2. On the left panel, choose "Webooks"
3. "Add webhook" on the top-right
4. In the Payload URL field, enter the Jenkins webhook URL, which usually looks like this: http://your-jenkins-url/github-webhook/
5. Set Content type to "application/json"
7. Under Which events would you like to trigger this webhook?, select "Just the push event to trigger the webhook only on code pushes."
8. Click "Add webhook".

# Setup SSH access to Jenkins on ClientServer VM

1. Go back to the terminal on your 
Server VM and access your Jenkins user to create your Jenkins SSH Key:

  ```` sudo su - jenkins ````

```` ssh-keygen -t ed25519 -C "jenkins@[your-server -vm-name]" -f ~/.ssh/id_ed25519 -N "" ````

```` cat ~/.ssh/id_ed25519.pub ````

2. Copy the public key that is displayed and save it for later

3. Access your ClientServer VM using SSH through your CloudServer VM and create a SSH Key for this VM:

```` ssh-keygen -t ed25519 ````

4. Visualize the Keys created e copy this information and save it for later:

```` ls -l ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub ````
```` vi id_ed25519 ```` #privatekey 
```` vi id_ed25519.pub ```` #publickey 

5. Append the jenkins public key that you saved before to the ClientServer 'authorized_keys' file:

```` echo "[your jenkins public key]" >> ~/.ssh/authorized_keys ````
```` chmod 600 ~/.ssh/autorized_keys ````

6. Go back to your CloudServer VM and as Jenkins user try the connection to your ClientServer VM:

```` sudo su - jenkins ````
```` ssh -i ~/.ssh/id_ed25519 your-clientserver-user@your-clientserver-vm-ip ```` 


# Finalizing Jenkins pipeline Configuration

1. Add SSH Key to Jenkins Credentials
 a. Go to Jenkins Dashboard > Manage Jenkins > Manage Credentials.
 b. Under Global credentials, click Add Credentials an configure as below:

   *Kind: SSH Username with private key.
   *Username: Enter the SSH user for the Azure VM (e.g., azureuser).
   *Private Key: Choose Enter directly and paste the contents of your private SSH key (id_ed25519).
   *ID: Give it an ID such as AzureUser. (This will be the same for "SSH_Credentials_ID" in your jenkinsfile)


# Set Up the Jenkins Pipeline

1. In Jenkins, create a new pipeline project:

 a. Go to Jenkins Dashboard > New Item.
Choose Pipeline, give it a name,  and select Github Project

 b. Under General, check the GitHub Project checkbox.
Enter the GitHub repository URL (e.g., https://github.com/your-org/your-repo).

 c. To enable Jenkins to pull code from your GitHub repository, configure the Source Code Management (SCM) section.

2.  In the Pipeline job configuration:

a. Scroll down to the Source Code Management section.
b. Select Git.
c. Enter your Repository URL (e.g., https://github.com/your-org/your-repo.git).
d. Specify the branch to build (e.g., main or */main).
e. Select GitHub hook trigger for GITScm polling.
f. save it and build the pipeline
























  
   





        

        
     





