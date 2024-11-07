#Updating System
echo "updating system.."
sudo apt update
sudo apt upgrade -y

#Install Java and verify
echo "installing Java.."
sudo apt install fontconfig openjdk-17-jre
java -version


#Download and install Jenkins 
echo "adding repository key..."
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "updating list file.."
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "updating and installing Jenkins..."
sudo apt-get update
sudo apt-get install jenkins -y 

echo"checking Jenkins version"
jenkins --version


#Start Jenkins and Enable Jenkins to start on boot
echo "starting Jenkins.."
sudo systemctl start jenkins
sudo systemctl enable jenkins

#Check Jenkins Status
sudo systemctl status jenkins








