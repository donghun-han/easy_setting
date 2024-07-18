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

# echo "Image name: $IMAGE_NAME"
docker run \
    -it \
    --rm \
    --env "TERM=xterm-256color" \
    --network=host \
    --name ${DOCKERFILE_DIR}_${DOCKERFILE_NAME} \
    $IMAGE_NAME \
    /bin/bash