#!/bin/sh
DIR_PORTAINER_DATA=/srv/portainer_data

docker run -d -p 8000:8000 -p 9443:9443 --name portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $DIR_PORTAINER_DATA:/data \
  portainer/portainer-ce:latest

# optional - hardcode version in image tag
