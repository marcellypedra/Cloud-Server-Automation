#-----CREATING EXPRESS DOCKER IMAGE--------#

#create a new directory for the application and install node.js
mkdir app
cd app
sudo apt install npm
npm init -y
npm install express

#create files required for node.js run express
#touch app.js #pull it from Github?
#touch package.json #pull it from Github?

#create files required for Docker image
#touch dockerfile #pull this from Github?

#Run Ansible to automate the image creation and run
ansible-playbook -i inventory.ini express-app.yml


#create docker image and run docker container
docker build -t express-app
docker run -p 3000:3000 express-app

#check if the container is running
docker ps -a
docker logs [container ID]

 












