#!/bin/sh

errMsg="err, usage: me.sh app_name win_name cmd_full; exit code 25" 
#若函数参数少于3个，则退出（退出码为25）
[ $# -lt 3 ] && { echo  $errMsg && return 25 ;}

process_name=$1
win_name=$2
cmd_full=$3

echo "process_name=【$process_name】,win_name=【$win_name】,cmd_full=【$cmd_full】"

set -x
( pidof $process_name && xdotool search --onlyvisible  $win_name windowactivate ) || ( set +x && echo "新启动【$cmd_full】" && $cmd_full & ) 
set +x