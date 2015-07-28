#!/bin/bash
. ./config

./stop.sh

echo "Destroying container."
docker rm -fv $SPIGOT_NAME

