#!/bin/sh

errMsg="win_activ.sh: err arg1 required,exit code 23" 
#若函数参数少于1个，则退出（退出码为23）
[ $# -lt 1 ] && { echo  $errMsg && return 23 ;}

set -x
win_name=$1
xdotool search --onlyvisible  $win_name windowactivate && set +x && echo "已激活 $win_name"
