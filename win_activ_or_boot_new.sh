#!/bin/sh

errMsg="win_activ_or_boot_new.sh: err arg1 required,exit code 23" 
#若函数参数少于1个，则退出（退出码为23）
[ $# -lt 1 ] && { echo  $errMsg && return 23 ;}

app_name=$1
xdotool search --onlyvisible  $app_name windowactivate && echo "已激活 $app_name"

( pidof $app_name && xdotool search --onlyvisible  $app_name windowactivate ) || ( echo "新启动【$app_name】" && $app_name & ) 