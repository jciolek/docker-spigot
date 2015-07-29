#!/bin/bash
. ./config

./stop.sh

if ! docker ps -a|grep -q $SPIGOT_NAME; then
  echo "Container does not exist. Skipping destroy."
else
  echo "Destroying container."
  docker rm -fv $SPIGOT_NAME
fi
