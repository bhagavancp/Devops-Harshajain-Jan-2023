#!/bin/bash
sudo apt udpate 
sudo apt-get install -y ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install docker 
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
[[ -f "$(which docker)" ]] && echo "   Docker is installed successfuly"

# Run jenkins contianer using docker
[[ -d '/var/jenkins_home' ]] || { mkdir -p '/var/jenkins_home'; sudo chmod 777 '/var/jenkins_home'; }
sudo docker run -d -it -u 0 --name jenkins-master -p 8080:8080 -p 50000:50000 \
                -v /var/jenkins_home:/var/jenkins_home \
                -v /var/run/docker.sock:/var/run/docker.sock \
                -v $(which docker):/usr/bin/docker jenkins/jenkins:lts

# To get initial admin password 
# sudo docker exec -it --user root jenkins-master cat /var/jenkins_home/secrets/initialAdminPassword
