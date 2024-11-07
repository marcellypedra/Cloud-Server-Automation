#Updating System
echo "updating system.."
sudo apt update
sudo apt upgrade -y

#Install Java and verify
echo "installing Java.."
sudo apt install openjdk-11-jdk -y
java -version

#Download and add the Jenkins repository key
echo "adding repository key..."
wget -q -O - https://pkg.jenkins.io/jenkins.io.key | sudo tee /etc/apt/trusted.gpg.d/jenkins.asc

#Add the Jenkins repository to your package manager
sudo sh -c 'echo deb http://pkg.jenkins.io/debian/ / > /etc/apt/sources.list.d/jenkins.list'

#Update repository info
sudo apt update

#install Jenkins
echo "installing Jenkins.."
sudo apt install jenkins -y

#Start Jenkins and Enable Jenkins to start on boot
echo "starting Jenkins.."
sudo systemctl start jenkins
sudo systemctl enable jenkins

#Check Jenkins Status
sudo systemctl status jenkins








