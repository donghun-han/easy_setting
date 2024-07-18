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

docker run \
    -it \
    --rm \
    --gpus all \
    --env "NVIDIA_VISIBLE_DEVICES=all" \
    --env "NVIDIA_DRIVER_CAPABILITIES=compute, graphics, utility" \
    --env "TERM=xterm-256color" \
    --network=host \
    --name ${DOCKERFILE_DIR}_${DOCKERFILE_NAME} \
    $IMAGE_NAME \
    /bin/bash
