#!/bin/sh

cd /home/g/
{ pidof gitea-1.21.2-linux-arm64 &&  echo  "   gitea shutdown... " && ./gitea-1.21.2-linux-arm64 manager shutdown ;} || { echo "no gitea pid!"  ;} 
