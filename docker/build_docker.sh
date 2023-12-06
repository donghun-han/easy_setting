#!/bin/bash
# You should pass the argument when run this script
# $1: docker image name
# $2: dockerfile path

IMAGE_NAME="$1"
DOCKERFILE_PATH="$2"

sudo docker build -t $1 -f $2 \
									--build-arg ssh_prv_key="$(cat ~/.ssh/id_rsa)" \
									--build-arg ssh_pub_key="$(cat ~/.ssh/id_rsa.pub)" .