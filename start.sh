#!/bin/bash
. ./config

if ! docker ps -a|grep -q $SPIGOT_NAME; then
  echo "Creating container."
  docker run -itd \
    --restart=always \
    -p 25565:25565 \
    --name=$SPIGOT_NAME \
    -v $(pwd)/data:/minecraft \
    webnicer/spigot:$SPIGOT_VERSION
elif docker ps -f status=paused|grep -q $SPIGOT_NAME; then
  echo "Container paused. Unpausing container."
  docker unpause $SPIGOT_NAME
elif docker ps -f status=running|grep -q $SPIGOT_NAME; then
  echo "Container already running. Skipping start."
else
  echo "Starting container."
  docker start $SPIGOT_NAME
fi

