#!/bin/sh

#[描述] 查找是否有jetbrains系列ide的jvm进程

export JAVA_HOME=/app/jdk8
export PATH=$JAVA_HOME/bin:$PATH
which jcmd
#which jcmd==/app/jdk8/bin/jcmd


function jetbrains_jvm_pid_is_x(){
local jetbrains_ide_name=$1
#jetbrains_ide_name := [clion, idea, pycharm, ...]
local pid=$2
jcmd $pid VM.system_properties 2>/dev/null | grep jb.vmOptionsFile | grep  "${jetbrains_ide_name}64.vmoptions\|${jetbrains_ide_name}.vmoptions"
}
#函数单元测试
# jetbrains_jvm_pid_is_x clion $pid && echo find_clion
# jb.vmOptionsFile=/app/clion-2022.3.3/bin/clion64.vmoptions
# find_clion

function jetbrains_ide_process_find(){
local jetbrains_ide_name=$1
#jetbrains_ide_name := [clion, idea, pycharm, ...]

local OK=0
local NO=1
local has=false
# pidof java  可以替换 jps
jps -q | while IFS= read -r pid_j ; do  jetbrains_jvm_pid_is_x $jetbrains_ide_name  $pid_j && echo loop_j_find_clion && has=true; done
$has && return $OK
return $NO
}
#函数单元测试
#jetbrains_ide_process_find clion && echo find_clion

#开发用语句:
#pid=$(/app/jdk8/bin/jps -l | grep idea|cut -d' ' -f1)
# /app/jdk8/bin/jcmd $pid VM.system_properties | grep jb.vmOptionsFile | grep  "clion64.vmoptions\|clion.vmoptions"
# jb.vmOptionsFile=/app/clion-2022.3.3/bin/clion64.vmoptions
