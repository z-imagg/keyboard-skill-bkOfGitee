```shell
Home=/app
GitRepo=$Home/sxhkd-xtotool--warpd--VimiumC
cd $Home/

git clone http://giteaz:3000/misc/sxhkd-xtotool--warpd--VimiumC.git
#/app/sxhkd-xtotool--warpd--VimiumC/.git/config
git update-index --chmod=+x  sxhkd_xdotool_script/*.sh
chmod +x $GitRepo/sxhkd_xdotool_script/*.sh

sudo unlink /sxScript
sudo ln -s $GitRepo/sxhkd_xdotool_script   /sxScript


ln -s  $GitRepo/.config/sxhkd ~/.config/sxhkd

```


[sxhkd-xdotool.md](http://giteaz:3000/misc/sxhkd-xtotool/src/branch/main/sxhkd-xdotool.md)， [sxhkd(按键)+xdotool(X11窗口工具）](https://blog.csdn.net/hfcaoguilin/article/details/135623440#t0)



[键盘代替鼠标warpd.md](http://giteaz:3000/misc/sxhkd-xtotool/src/branch/main/keyboard_as_mouse--warpd.md)