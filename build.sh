#!/bin/bash
. ./config

docker build -t webnicer/spigot:$SPIGOT_VERSION image

