#!/bin/bash

#[描述] 根据是否有jetbrain_ide clion进程 来启动新clion或激活clion窗口
#[用法] source /app/keyboard-skill/sxhkd_xdotool_script/jetbrains_ide__win_activ_or_boot_new_full.sh ;  jetbrains_ide__win_activ_or_boot_new_full clion  /app/clion-2022.3.3/bin/clion.sh


function jetbrains_ide__win_activ_or_boot_new_full(){
local OK=0
local ERR=25

local jetbrain_ide_name=$1
local win_name=$jetbrain_ide_name
local cmd_full=$2

local errMsg="err, usage: source jetbrains_ide__win_activ_or_boot_new_full.sh  ; example: jetbrains_ide__win_activ_or_boot_new_full clion  /app/clion-2022.3.3/bin/clion.sh; exit code 25" 
#若函数参数少于2个，则退出（退出码为25）
[ $# -lt 2 ] && { echo  $errMsg && return $ERR ;}



source   /app/bash-simplify/jetbrain_java_pid_get.sh

echo "[收到入参] jetbrain_ide_name=【$jetbrain_ide_name】,win_name=【$win_name】,cmd_full=【$cmd_full】"

local has_process=false
jetbrains_ide_process_find $jetbrain_ide_name && jetbrain_ide_jvm_pid=$(jetbrains_ide_process_find $jetbrain_ide_name)  && has_process=true

#若已有该进程，则激活窗口即可
local msg_actvWin="激活现有窗口jetbrain_ide, win_name=[$win_name]"
$has_process && xdotool search --onlyvisible  "$win_name" windowactivate && { echo "$msg_actvWin"; return $OK ;}

#否则（尚无该进程） ，则后台启动新启动
local msg_newBoot="新启动jetbrain_ide, cmd_full=[$cmd_full]"
(  $cmd_full & )  &&  { echo "$msg_newBoot"; return $OK ;}


#调试语句（给定窗口名，打印窗口id、命令全路径、窗口全名）：
#人工用clion打开两个项目
#xdotool search --onlyvisible  clion  | xargs -I@ sh -c "echo -n @: ; xdotool getwindowname @"
# Defaulting to search window name, class, and classname
# 52428880:clangPlugin-Var – test_main.cpp
# 52428883:Content window
# 52429445:clangPlugin-Var [/fridaAnlzAp/clp-zz] – /app/llvm_release_home/clang+llvm-15.0.0-x86_64-linux-gnu-rhel-8.4/include/clang/AST/Type.h
# 52429448:Content window
}

