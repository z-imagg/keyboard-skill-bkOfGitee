
sxhkd按键名称列表： https://github.com/baskerville/sxhkd/blob/master/src/parse.c

## dependency
```shell
sudo apt install sxhkd  xdotool   kdialog wmctrl
```

## 拉取本代码仓库
```shell
Home=/app
GitRepo=$Home/keyboard-skill
cd $Home/

git clone http://giteaz:3000/wiki/keyboard-skill.git
#/app/keyboard-skill/.git/config


cd $GitRepo
git config core.filemode false #git 忽略当前仓库 的 文件权限
git config --global core.filemode false #git 全局忽略 的 文件权限

```

## 按键触发命令(sxhkd)、X11窗口操纵(xdotool)

###  安装、配置 ： 按键触发命令(sxhkd)、X11窗口操纵(xdotool) 

**前提： 禁止Wayland（恢复x11协议）**, https://blog.csdn.net/hfcaoguilin/article/details/135203694#t7

按键触发命令(sxhkd)、X11窗口操纵(xdotool)  :  http://giteaz:3000/wiki/keyboard-skill/src/branch/main/sxhkd-xdotool.md， 
或 https://blog.csdn.net/hfcaoguilin/article/details/135623440#t0)


```sudo apt install kdialog```



### 关联 本仓库的  按键触发命令(sxhkd) 到 本地操作系统
```shell

sudo unlink /sxScript
sudo ln -s $GitRepo/sxhkd_xdotool_script   /sxScript


ln -s  $GitRepo/.config/sxhkd ~/.config/sxhkd


```

###  开机启动(手动)
```shell
bash /app/keyboard-skill/sxhkd_xdotool_script/loopWaitAt_namePIPE_do_sxhkd_reboot.sh
```

##  键盘代替鼠标warpd

[键盘代替鼠标warpd.md](http://giteaz:3000/wiki/keyboard-skill/src/branch/main/keyboard_as_mouse--warpd.md)

###  开机启动(手动)
```shell
/app/warpd/bin/warpd &
```

## npx autocomplete
[npx_autocomplete.sh](http://giteaz:3000/wiki/keyboard-skill/src/branch/main/npx_autocomplete.sh)，复制自[gibatronic#gistcomment-3893973](https://gist.github.com/gibatronic/44073260ffdcbd122e9520756c8e35a1?permalink_comment_id=3893973#gistcomment-3893973)



###  ~/.bashrc添加以下内容
```shell
source /app/keyboard-skill/npx_autocomplete.sh
```
