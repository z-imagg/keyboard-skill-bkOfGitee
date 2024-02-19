#!/bin/sh

cd /home/g/
{ pidof gitea-1.21.2-linux-arm64 &&  echo  "   gitea already boot!" ;} || { echo "boot gitea..." ; ( nohup ./gitea-1.21.2-linux-arm64 web & ) ;  pid=$! ; echo "gitea gieta_pid = [$pid]" ;} 
