#!/bin/sh

docker run -d \
    --name watchtower \
    --restart=unless-stopped \
    -v /var/run/docker.sock:/var/run/docker.sock \
    containrrr/watchtower \
    --cleanup

# optional - hardcode version in image tag
