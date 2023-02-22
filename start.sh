#!/bin/bash 
MY=$(sudo docker-compose -v | grep -oP 'v[0-9]{1,}.[0-9]{1,}.[0-9]{1,}')
NEED=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*\d')
echo $MY
echo $NEED
if [[ "$MY" != "$NEED" ]]; then
	echo "U need update docker-compose"
	DESTINATION=/usr/bin/docker-compose
	sudo curl -L https://github.com/docker/compose/releases/download/${NEED}/docker-compose-$(uname -s)-$(uname -m) -o $DESTINATION
	sudo chmod 755 $DESTINATION
else
	echo "U have the latest version"
fi
MY=$(sudo docker-compose -v | grep -oP 'v[0-9]{1,}.[0-9]{1,}.[0-9]{1,}')
if [[ "$MY" != "$NEED" ]]; then
	echo "Error updating docker-compose!! Try to update it manually"
else
	sudo docker-compose up -d
fi
