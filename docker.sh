#-----CREATING EXPRESS DOCKER IMAGE--------#

#create a new directory for the application and install node.js
[ ! -d app ] && mkdir app
cd app
sudo apt install npm
npm init -y
npm install express

cd ..

#create files required for node.js run express
#touch app.js #pull it from Github?
#touch package.json #pull it from Github?

#create files required for Docker image
#touch dockerfile #pull this from Github?

#Run Ansible to automate the image creation and run
ansible-playbook -i inventory.ini express-app.yml


#create docker image and run docker container
docker buildx build -t express-app:latest .

# Stop any containers using port 3000
docker ps -q --filter "ancestor=express-app" | xargs docker stop

# Run the Docker container, mapping to an available port
docker run -p 3000:3000 express-app

#check if the container is running
container_id=$(docker ps -l -q)
docker logs "$container_id"

 












