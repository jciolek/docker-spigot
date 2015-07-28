#!/bin/bash
. ./config

if docker ps -f status=exited|grep -q $SPIGOT_NAME; then
  echo "Container already stopped. Skipping."
else
  echo "Stopping container."
  docker stop $SPIGOT_NAME
fi

