#!/bin/bash

case $1 in
	kinetic)
		DOCKER_FILE=ros_kk
	;;
	melodic)
		DOCKER_FILE=ros_mm
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
sudo docker build -t ros_$1 . --no-cache -f $DOCKER_FILE
sudo docker run -itd \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --name "$1" \
    ros_$1
export containerId=$(sudo docker ps -l -q)

