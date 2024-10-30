#create a new directory for the application and install node.js
mkdir express-app
cd express-app
sudo apt install npm
npm init -y
npm install express

#create files required for node.js run express
touch app.js #pull this from Github?
touch package.json #pull this from Github?

#create docker image and run docker container
touch dockerfile #pull this from Github?
docker build -t express-app
docker run -p 3000:3000 express-app

#check if the container is running
docker ps -a
docker logs [container ID]







#run express from node.js
npm start





#Add the User to the Docker Group for access permission
sudo usermod -aG docker [VM username]
newgrp docker
docker ps



#Starter Docker
docker run -d -p 80:80 docker/getting-started

#check for previous images and containers
docker images -a
docker ps -a

#Create a new container and download the latest version image app(nginx) from docker hub 
docker run -d nginx

#stopped container
docker stop [container ID]

#start container
docker start [container ID]

#Publish container's port to the host
docker run --name [container name] -d -p [host port]:80 nginx
#only 1 service can run in each port
#standard use the port at host as the one used in the container

#confirmation that the image is now running in the right port
docker logs [container ID]

#building the image form the docker file
docker build -t [image name]:[tag] . 







