#!/bin/bash
. ./config

HOST=$1

# echo "Uploading spigot image."
# docker save webnicer/spigot:$SPIGOT_VERSION | bzip2 | pv | ssh root@$HOST 'bunzip2 | docker load'

ssh $HOST -l root << EOF
  echo "Installing toolkit."
  apt-get update
  apt-get install -y git

  cd
  if [ ! -f /swapfile ]; then
    echo "Creating swapfile."
    fallocate -l 2G /swapfile
    chmod 600 /swapfile 
    mkswap /swapfile
    swapon /swapfile
  else
    echo "Swapfile exists. Skipping."
  fi

  if ! grep -q /swapfile /etc/fstab; then
    echo "Adding swap to fstab."
    echo "/swapfile none swap sw 0 0" >> /etc/fstab
  else
    echo "Swap already added to fstab. Skipping."
  fi

  if ! grep -q vm.swappiness /etc/sysctl.conf; then
    echo "Configuring swappiness."
    echo "vm.swappiness = 10" >> /etc/sysctl.conf
    sysctl -p
  else
    echo "Swappiness already configured. Skipping."
  fi

  if [ ! -d docker-spigot ]; then
    echo "Cloning repository."
    git clone https://github.com/jciolek/docker-spigot.git
  else
    echo "The repo already exists. Skipping."
  fi

  cd docker-spigot
  echo "Updating repo."
  git fetch
  git merge origin/master

  ./build.sh
  ./start.sh

EOF
