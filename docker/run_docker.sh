#!/bin/bash
# You should pass the argument when run this script
# $1: docker container name
# $2: docker image name

XSOCK=/tmp/.X11-unix; 
XAUTH=/tmp/.docker.xauth; touch $XAUTH; xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -; \
if [ ! -f $XAUTH ]
then
    xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
    if [ ! -z "$xauth_list" ]
    then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    else
        touch $XAUTH
    fi
    chmod a+r $XAUTH
fi


CONTAINER_NAME="$1"
IMAGE_NAME="$2"

docker run -it \
           --name=${CONTAINER_NAME} \
           --env="DISPLAY=${DISPLAY}" \
           --env="XAUTHORITY=${XAUTH}" \
           --env=TERM=xterm-256color \
           --env="QT_X11_NO_MITSHM=1" \
           --volume=$XSOCK:$XSOCK:rw \
           --volume=$XAUTH:$XAUTH:rw \
           --volume=/home/donghun/docker_shared:/shared_data \
           --shm-size=4gb \
           --runtime=nvidia \
           --privileged \
           --gpus all \
           --net=host \
           --user docker_melodic \
           ${IMAGE_NAME} \
           /bin/bash