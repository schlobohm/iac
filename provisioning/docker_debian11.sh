#!/bin/sh

# [[ Following guide from https://docs.docker.com/engine/install/debian/ as at 13 April 2022 ]]

# Uninstall old versions
# -- Older versions of Docker were called docker, docker.io, or docker-engine. If these are installed, uninstall them:
dpkg --remove docker docker-engine docker.io containerd runc

# Install using the repository
# -- Set up the repository
# ---- Update apt package index
sudo apt-get update

# ---- Install packages to allow apt to use a repository over HTTPS
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# ---- Add Docker GPG key
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# ---- Set up the stable repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# -- Install Docker Engine
# ---- Update apt package index
sudo apt-get update

# ---- Install latest version of Docker Engine and containerd
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
