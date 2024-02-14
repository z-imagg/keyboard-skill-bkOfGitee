#!/bin/bash

set -x

{ ( sleep 2 &&  sxhkd & ) & } && kill $(pidof sxhkd)

set +x
{ ( sleep 2.3 && echo -e "sxhkd's PID: 【$(pidof sxhkd)】; ok \n" ) & }


#用kdialog显示一个对本自定义快捷键干净的窗口
kill $(pidof kdialog)
grep "##" /app/keyboard-skill/.config/sxhkd/sxhkdrc | sed "s/##//g" | kdialog --textbox -  650 300 &
#kdialog 文档: https://develop.kde.org/docs/administration/kdialog/#kdialog-dialog-types

