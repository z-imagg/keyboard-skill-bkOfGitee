#!/bin/sh

errMsg="err, usage: me.sh app_name win_name cmd_full; exit code 25" 
#若函数参数少于3个，则退出（退出码为25）
[ $# -lt 3 ] && { echo  $errMsg && return 25 ;}

process_name=$1
win_name=$2
cmd_full=$3

echo "process_name=【$process_name】,win_name=【$win_name】,cmd_full=【$cmd_full】"

set -x
( pidof $process_name && xdotool search --onlyvisible  "$win_name" windowactivate ) || ( set +x && echo "新启动【$cmd_full】" && $cmd_full & ) 
set +x

#调试语句（给定窗口名，打印窗口id、命令全路径、窗口全名）：
#xdotool search --onlyvisible  notepad  | xargs -I@ sh -c "echo -n @: ; xdotool getwindowname @"
#Defaulting to search window name, class, and classname
#58720264:/app/keyboard-skill/sxhkd_xdotool_script/win_activ_or_boot_new_full.sh — Notepad Next
