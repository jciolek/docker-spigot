#!/bin/bash
. ./config

if docker ps -f status=exited|grep -q $SPIGOT_NAME; then
  echo "Container already stopped. Skipping stop."
elif ! docker ps -a|grep -q $SPIGOT_NAME; then
  echo "Container does not exist. Skipping stop."
else
  echo "Stopping container."
  docker stop $SPIGOT_NAME
fi

