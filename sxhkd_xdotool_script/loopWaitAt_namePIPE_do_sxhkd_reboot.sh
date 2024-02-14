#!/bin/bash

# 在进程sxhkd内(sxhkd中定义的按键) 重启 自身 不是好方案，好方案为： 一独立脚本 中 循环 从 命名管道读取指令 以重启进程sxhkd

#使用说明:
#1. 启动循环接受指令脚本（即此脚本，从命名管道读取指令）:  bash /app/keyboard-skill/sxhkd_xdotool_script/loopWaitAt_namePIPE_do_sxhkd_reboot.sh
#2. 在其他终端下 向 命名管道  写入 重启指令 : echo 'reboot' > /tmp/sxhd_reboot_namePIPE_  以触发 脚本1 重启 sxhd
#         支持的指令: 
#             reboot : 重启sxhkd 
#             reboot_then_dialog : 重启sxhkd 并以 kdialog显示sxhkd配置文件中的快捷键说文档

function dialog_notification() {
# set +x

#sudo apt install  zenity


#若函数参数少于1个，则直接返回(退出码依然为0)
[ $# -lt 1 ] && { return 0 ;}

_msgTxt=$1

# 通知窗口： 持续时长约10秒由操作系统ubuntu22控制（不由命令控制）、 不占用焦点
#zenity --timeout 1 --notification --text "zzzz"
kdialog --title "$_msgTxt" --passivepopup "newPid:$newPid" 1

#非通知的一般窗口： 持续时长由命令设置、占用的焦点
# zenity --timeout 1 --info --text "$_msgTxt"



# set -x

}

function dialog_sxhkd_shortKey() {
# set +x

#sudo apt install  kdialog

#用kdialog显示一个对本自定义快捷键干净的窗口
pkill --exact -f kdialog
grep "##" /app/keyboard-skill/.config/sxhkd/sxhkdrc | sed "s/##//g" | kdialog --textbox -  650 300 &
#kdialog 文档: https://develop.kde.org/docs/administration/kdialog/#kdialog-dialog-types
# set -x
}

function reboot_sxhkd() {

  { pkill --exact -f  sxhkd || echo -n "当前无进程sxhkd，即将新启动," ;} && { { sxhkd & } && newPid=$! && echo "新进程ID:$newPid" ;} 

}

# set -x

F_NamePIPE=/tmp/sxhd_reboot_namePIPE_

#删除命名管道，防止存在
rm -f $F_NamePIPE

#创建命名管道
mkfifo $F_NamePIPE

Cmd_Reboot='reboot'
Cmd_RebootThenDialog='reboot_then_dialog'

while true; do
  # set -x
  
  read msg < $F_NamePIPE # 当 命名管道文件 中没有内容时， 阻塞等待在此行

  if [[ "$msg" == "$Cmd_Reboot" ]] ; then
    reboot_sxhkd && dialog_notification "正常重启sxhkd"
  fi
  
  if [[ "$msg" == "$Cmd_RebootThenDialog"  ]] ; then
    reboot_sxhkd &&  dialog_sxhkd_shortKey
  fi
  

done

# set +x