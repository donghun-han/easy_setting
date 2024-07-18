#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <Dockerfile>"
  exit 1
fi

DOCKERFILE_PATH=$1

DOCKERFILE_DIR=$(dirname "$DOCKERFILE_PATH")
DOCKERFILE_NAME=$(basename "$DOCKERFILE_PATH" .dockerfile)

# Construct the image name and tag
IMAGE_NAME="usrg_drone/$DOCKERFILE_DIR:$DOCKERFILE_NAME"

HOST_UID=$(id -u)
HOST_GID=$(id -g)

docker build \
    --build-arg UID=$HOST_UID \
    --build-arg GID=$HOST_GID \
    --file $DOCKERFILE_PATH \
    --tag $IMAGE_NAME \
    .
