```shell
cd /app/
git clone http://giteaz:3000/misc/sxhkd-xtotool--warpd--VimiumC.git
#/app/sxhkd-xtotool--warpd--VimiumC/.git/config
chmod +x /app/sxhkd-xtotool--warpd--VimiumC/sxhkd_xdotool_script/*.sh

sudo unlink /sxScript
sudo ln -s /app/sxhkd-xtotool--warpd--VimiumC/sxhkd_xdotool_script   /sxScript


ln -s  /app/sxhkd-xtotool--warpd--VimiumC/.config/sxhkd ~/.config/sxhkd

```


[sxhkd-xdotool.md](http://giteaz:3000/misc/sxhkd-xtotool/src/branch/main/sxhkd-xdotool.md)， [sxhkd(按键)+xdotool(X11窗口工具）](https://blog.csdn.net/hfcaoguilin/article/details/135623440#t0)



[键盘代替鼠标warpd.md](http://giteaz:3000/misc/sxhkd-xtotool/src/branch/main/keyboard_as_mouse--warpd.md)