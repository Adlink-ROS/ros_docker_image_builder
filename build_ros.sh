#!/bin/bash

case $1 in
	kinetic)
		DOCKER_FILE=ros_kk
		IMAGE_NAME=ros1_$1
	;;
	melodic)
		DOCKER_FILE=ros_mm
		IMAGE_NAME=ros1_$1
	;;
	dashing)
		DOCKER_FILE=ros2_dd
		IMAGE_NAME=ros2_$1
	;;
	*)
		if [ -z $1 ]; then
			echo "Usage: $0 version_name"
		else
			echo "No such version $1!"
		fi
			exit
	;;
esac

echo "Building $1"

sudo xhost local:root
sudo xhost +local:root
sudo docker build -t $IMAGE_NAME . --no-cache -f $DOCKER_FILE
sudo docker run -itd \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --name "$1" \
    $IMAGE_NAME
export containerId=$(sudo docker ps -l -q)

