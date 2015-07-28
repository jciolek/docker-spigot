#!/bin/bash
. ./config

if docker ps -f status=running|grep -q $SPIGOT_NAME; then
  echo "Press CTRL+P CTRL+Q to detach."
  docker attach --sig-proxy=false $SPIGOT_NAME
else
  echo "Container not running. Start it first!"
fi

