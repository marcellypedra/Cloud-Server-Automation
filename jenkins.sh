#!/bin/bash

# Updating system
echo "updating system.."
sudo apt update
sudo apt upgrade -y

# Creates a memory for swap file
echo "creating swap file.."
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Checking if Git is installed, install if missing
if ! command -v git &> /dev/null; then
    echo "@@ Installing Git..."
    sudo apt install git -y
else
    echo "@@ Git is already installed"
fi

# Setting path to Git executable
GIT_PATH=$(which git)
echo "@@ Git path set to: $GIT_PATH"

# Configure known_hosts entry for GitHub
KNOWN_HOSTS_FILE=~/.ssh/known_hosts
GITHUB_HOST="github.com"
mkdir -p ~/.ssh

# Adding github.com to known_hosts
if ! ssh-keygen -F "$GITHUB_HOST" &>/dev/null; then
    echo "@@ Adding $GITHUB_HOST to known_hosts..."
    ssh-keyscan -H "$GITHUB_HOST" >> "$KNOWN_HOSTS_FILE"
else
    echo "@@ $GITHUB_HOST already exists in known_hosts"
fi

# Install Java and verify
echo "installing Java.."
sudo apt install openjdk-17-jre -y
java -version

# Download and install Jenkins
echo "adding repository key..."
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "updating list file.."
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "updating and installing Jenkins..."
sudo apt-get update
sudo apt-get install jenkins -y 

echo "checking Jenkins version"
jenkins --version

# Docker group for Jenkins user
sudo usermod -aG docker jenkins

# Start Jenkins and Enable Jenkins to start on boot
echo "starting Jenkins.."
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Restart Jenkins to apply Docker group permissions
echo "@@ Restarting Jenkins to apply permissions..."
sudo systemctl restart jenkins

# Check Jenkins Status
sudo systemctl status jenkins

echo "## Jenkins installation and setup complete!"
echo "Please restart your machine or log out and log back in for Docker group changes to take effect."










