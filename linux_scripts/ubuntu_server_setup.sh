#! /bin/bash

echo "
###################################
 Time to setup your Ubuntu server!
###################################

For more details, please visit the repository at https://github.com/johnhebron/shell_scripts
"

echo "
###################################
Step 1: Install Basic Pkgs
###################################
"
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

echo "
###################################
Step 2: Add gpg Key
###################################
"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "
###################################
Step 3: apt update
###################################
"
sudo apt update -y

echo "
###################################
Step 4: Install docker-ce
###################################
"

apt-cache policy docker-ce

sudo apt install docker-ce -y

echo "
###################################
Step 5: Set docker user perms
###################################
"

sudo usermod -aG docker ${USER}

mkdir -p ~/.docker/cli-plugins/

curl -SL https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-linux-armv6 -o ~/.docker/cli-plugins/docker-compose

chmod +x ~/.docker/cli-plugins/docker-compose

docker compose version
