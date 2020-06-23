#!/bin/bash
DIR=$(dirname $(readlink -f $0))

case $1 in
	kinetic)
		DOCKER_FILE=ros_kk
	;;
	melodic)
		DOCKER_FILE=ros_mm
	;;
	indigo)
		DOCKER_FILE=ros_ii
	;;
	foxy)
		DOCKER_FILE=ros_ff
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

echo "Starting"
#echo "$(id -u):$(id -g)"
sudo docker run -itd -u $(id -u):$(id -g) \
    --privileged \
    --network host \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/dev:/dev:rw" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$DIR/$1_ws:/home/ros:rw" \
    --hostname $1 \
    --add-host $1:127.0.1.1 \
    --name $1 \
    ros_$1
sudo docker start -i $1
# export containerId=$(sudo docker ps -l -q)
