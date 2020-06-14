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

echo "Building $1"

sudo xhost local:root
sudo xhost +local:root
sudo docker build -t ros_$1 . --no-cache -f $DOCKER_FILE
./start_ros.sh $1
# export containerId=$(sudo docker ps -l -q)

