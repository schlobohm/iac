#!/bin/sh

# [[ Following guide from https://docs.docker.com/engine/install/centos/ as at 3 May 2022 ]]

# Uninstall old versions
# -- Older versions of Docker were called docker, docker.io, or docker-engine. If these are installed, uninstall them:
sudo dnf remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine

# Install using the repository
# -- Set up the repository
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# -- Install Docker Engine
sudo dnf install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable --now docker
