#!/bin/bash

#[描述] 根据是否有jetbrain_ide clion进程 来启动新clion或激活clion窗口
#[用法] source /app/keyboard-skill/sxhkd_xdotool_script/jetbrains_ide__win_activ_or_boot_new_full.sh ;  jetbrains_ide__win_activ_or_boot_new_full clion  /app/clion-2022.3.3/bin/clion.sh

errMsg="err, usage: me.sh app_name win_name cmd_full; exit code 25" 
#若函数参数少于2个，则退出（退出码为25）
[ $# -lt 2 ] && { echo  $errMsg && return 25 ;}


function jetbrains_ide__win_activ_or_boot_new_full(){
local OK=0
local jetbrain_ide_name=$1
local win_name=$jetbrain_ide_name
local cmd_full=$2

source   /app/bash-simplify/jetbrain_java_pid_get.sh

echo "jetbrain_ide_name=【$jetbrain_ide_name】,win_name=【$win_name】,cmd_full=【$cmd_full】"

local has_process=false
jetbrains_ide_process_find $jetbrain_ide_name && jetbrain_ide_jvm_pid=$(jetbrains_ide_process_find $jetbrain_ide_name)  && has_process=true

set -x
#若已有该进程，则激活窗口即可
$has_process && xdotool search --onlyvisible  "$win_name" windowactivate && { set +x; return $Ok ;}

#否则（尚无该进程） ，则后台启动新启动
local msg="新启动jetbrain_ide【$cmd_full】"
( echo "$msg" && $cmd_full & )  &&  { set +x; return $Ok ;}


#调试语句（给定窗口名，打印窗口id、命令全路径、窗口全名）：
#人工用clion打开两个项目
#xdotool search --onlyvisible  clion  | xargs -I@ sh -c "echo -n @: ; xdotool getwindowname @"
# Defaulting to search window name, class, and classname
# 52428880:clangPlugin-Var – test_main.cpp
# 52428883:Content window
# 52429445:clangPlugin-Var [/fridaAnlzAp/clp-zz] – /app/llvm_release_home/clang+llvm-15.0.0-x86_64-linux-gnu-rhel-8.4/include/clang/AST/Type.h
# 52429448:Content window
}

