#!/bin/sh

# [[ Adapted from https://docs.docker.com/engine/install/centos/ as at 3 May 2022 ]]

# Uninstall old versions
# -- Older versions of Docker were called docker, docker.io, or docker-engine. If these are installed, uninstall them:
sudo dnf remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine

# Install using the repository
# -- Set up the repository
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# -- Install Docker Engine
if [[ "$(cat /etc/centos-release)" == *"CentOS Stream release 9"* ]]; then
  # change 
  # baseurl=https://download.docker.com/linux/centos/$releasever/$basearch/stable
  sudo sed -i '/^baseurl=https:\/\/download\.docker\.com\/linux\/centos\/\$releasever\/\$basearch\/stable/a baseurl=https:\/\/download\.docker\.com\/linux\/centos\/8\/\$basearch\/stable' /etc/yum.repos.d/docker-ce.repo
  sudo sed -i '/^baseurl=https:\/\/download\.docker\.com\/linux\/centos\/\$releasever\/\$basearch\/stable/ s/./#&/' /etc/yum.repos.d/docker-ce.repo
  
  # download libcgroup
  cd "$(mktemp -d)"
  sudo dnf install -y wget
  wget http://mirror.centos.org/centos/8-stream/BaseOS/x86_64/os/Packages/libcgroup-0.41-19.el8.x86_64.rpm
  sudo dnf remove -y wget
  dnf install libcgroup-0.41-19.el8.x86_64.rpm -y
  
  # install Docker
  dnf install -y --nobest docker-ce docker-ce-cli containerd.io docker-compose-plugin
else
  dnf install -y --nobest docker-ce docker-ce-cli containerd.io docker-compose-plugin
fi

sudo systemctl enable --now docker
