#!/bin/bash

name=$1

for pid in $(ps -ef | grep ${name} | awk '{ print $2 }')
do
	echo "Killing process ${pid}"
	kill -9 ${pid}
done
