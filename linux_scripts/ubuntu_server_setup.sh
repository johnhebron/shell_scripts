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
if [ -e /usr/share/keyrings/docker-archive-keyring.gpg ]
then
	echo "GPG Key previously added. Skipping."
else
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo "GPG Key added."
fi

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

if ! command -v docker &> /dev/null
then

	apt-cache policy docker-ce

	sudo apt install docker-ce -y

	sudo usermod -aG docker ${USER}

	echo "Docker Installed."
else
	echo "Docker previously installed. Skipping."
fi

docker --version

echo "
###################################
Step 5: Install docker compose
###################################
"

if ! command -v docker compose &> /dev/null
then
	mkdir -p ~/.docker/cli-plugins/

	curl -SL https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-linux-armv6 -o ~/.docker/cli-plugins/docker-compose
	
	chmod +x ~/.docker/cli-plugins/docker-compose

	echo "Docker Compose Installed."
else
	echo "Docker Compose previously installed. Skipping."
fi

docker compose version

echo "
###################################
Step 6: Install secondary pkgs
###################################
"

sudo apt-get install fzf -y

echo "source /usr/share/doc/fzf/examples/key-bindings.bash" > ~/.bashrc

source ~/.bashrc
