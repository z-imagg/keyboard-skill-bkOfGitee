**前提： 禁止Wayland（恢复x11协议）**, https://blog.csdn.net/hfcaoguilin/article/details/135203694#t7

[sxhkd(按键)+xdotool(X11窗口工具）](https://blog.csdn.net/hfcaoguilin/article/details/135623440#t0)


#  sxhkd(按键)+xdotool(X11窗口工具）

- sxhkd:  定义按键触发脚本


- xdotool: X11窗口查找、激活等

参考：[sxhkd+wmctrl例子](https://bbs.eetop.cn/forum.php?mod=redirect&goto=findpost&ptid=920171&pid=10627205)


[sxhkd.git](https://github.com/baskerville/sxhkd.git)
## 安装 xdotool(X11窗口查找、激活等）
```sudo apt install xdotool```



## 安装 、配置 sxhkd(定义按键触发脚本)


```shell
sudo apt install sxhkd
sxhkd 
#Can't open configuration file: '/home/z/.config/sxhkd/sxhkdrc'.
mkdir  /home/z/.config/sxhkd/

```

##  xdotool激活窗口 尝试（调试语句） 
搜索含webstorm的窗口、显示pid和窗口名：
```shell
xdotool search --onlyvisible  webstorm | xargs -I@ sh -c "echo -n @: ; xdotool getwindowname @"
#Defaulting to search window name, class, and classname
#48234696:vue3_admin_template – App.vue
#48234699:Content window
```


激活webstorm: 
```shell
xdotool search --onlyvisible  webstorm windowactivate  #激活webstorm
```


## 将当前窗口移动到另一个显示器的同样位置（调试过程） 
获得当前活动窗口的位置、尺寸```xdotool getwindowgeometry --shell $(xdotool getactivewindow) ```输出：
```shell
WINDOW=46137351
X=2295
Y=288
WIDTH=1114
HEIGHT=680
SCREEN=0
```

```xrandr --listmonitors```显示器尺寸如下, 可知 两个显示器的宽度都是1920 
```txt
Monitors: 2
 0: +*eDP-1-1 1920/344x1080/193+1920+0  eDP-1-1
 1: +HDMI-0 1920/344x1080/195+0+0  HDMI-0
```

```shell
#获得当前活动窗口尺寸、位置
eval $(xdotool getwindowgeometry --shell $(xdotool getactivewindow) )

#定义 一个显示器的宽度
monitor_width=1920

#X 在 区间[0,2*monitor_width] 内，则X的另一个合法位置 X-monitor_width 或 X+monitor_width 只有一个 也在该区间内，以下代码计算X的另一个合法位置
signArr=(+1 -1)
signIdx=$(( X / monitor_width ))
newX=$(( X + signArr[signIdx] * monitor_width ))
echo "newX: $newX"


wmctrl -ir $active_win_id -e 0,$((newX)),$((Y)),$WIDTH,$HEIGHT
```

##  sxhkd+xdotool： 激活webstorm窗口



```/home/z/.config/sxhkd/sxhkdrc```文件新增内容如下：
```python 
#激活webstorm窗口
ctrl + alt + j ; w ;
      xdotool search --onlyvisible  webstorm windowactivate
```




```kill `pidof sxhkd `  ; sxhkd & ```后，按住 ```ctrl + alt + j```松开、再按住```w```松开 后 即可激活webstorm



比如 ```ctrl + alt + v ;```表示 同时按住ctrl、alt、v 后，再 都松开后触发

##  sxhkd+xdotool： 激活firefox窗口



```/home/z/.config/sxhkd/sxhkdrc```文件新增内容如下：
```python
#激活firefox窗口
ctrl + alt + w ; f ;
      xdotool search --onlyvisible  firefox  windowactivate
```



```kill `pidof sxhkd `  ; sxhkd & ```后，按住 ```ctrl + alt + w```松开、再按住```f```松开 后 即可激活webstorm



## sxhkd+xdotool : 激活gedit窗口或新启动gedit

```python
#激活gedit窗口或新启动gedit
ctrl + alt + g ; e ;
      ( pidof gedit && xdotool search --onlyvisible  gedit windowactivate ) || ( echo "新启动gedit" && gedit & ) 

```

```kill `pidof sxhkd `  ; sxhkd & ```后，按住 ```ctrl + alt + g```松开、再按住```e```松开 后 即可激活gedit

----

现在文件```/home/z/.config/sxhkd/sxhkdrc```内容：
```python 
#激活webstorm窗口
ctrl + alt + j ; w ;
      xdotool search --onlyvisible  webstorm windowactivate

#激活firefox窗口
ctrl + alt + w ; f ;
      xdotool search --onlyvisible  firefox  windowactivate

#激活gedit窗口或新启动gedit
ctrl + alt + g ; e ;
      ( pidof gedit && xdotool search --onlyvisible  gedit windowactivate ) || ( echo "新启动gedit" && gedit & ) 



```


## 其他（记录、备忘）
###  (Wayland  vs  X11) 下的 xdotool? 

[我目前在使用 KUbuntu 22.04 LTS 然而其默认的 KDE 5.24.7 版本依然还是 X11 版，](https://zhuanlan.zhihu.com/p/637159270)

[Ubuntu 21.04 为默认使用 Wayland 做积极准备](https://www.oschina.net/news/129823/ubuntu-21-04-wayland-plans)


----
```shell
cat /etc/issue
#Ubuntu 22.04.3 LTS \n \l

echo $XDG_SESSION_TYPE  
#x11

```

----

ubuntu21+ 默认使用的是Wayland

xdotool 是基于X11的，而 Wayland协议 和 X11协议 大部分是不同的，所以 基于X11的xdotool  操纵Wayland的ubuntu22会部分正常、部分不正常
```shell
xdotool search --title "Mozilla Firefox"
#This flag is deprecated. Assuming you mean --name (the window name).
#35651645
#35651800
#50331655

xdotool windowactivate 35651645
#XGetWindowProperty[_NET_WM_DESKTOP] failed (code=1)  #正常切换 但有此报错





xdotool search nautilus | xargs -I@ sh -c "echo -n @:; xdotool getwindowname @"
#Defaulting to search window name, class, and classname
#14694834:主文件夹
#14680065:org.gnome.Nautilus
#14680496:org.gnome.Nautilus
#14680072:web_ui

xdotool windowactivate 14694834 #正常激活

xdotool windowactivate 14680065
#XGetWindowProperty[_NET_WM_DESKTOP] failed (code=1)  #不切换


xdotool search vue | xargs -I@ sh -c "echo -n @:; xdotool getwindowname @"
#Defaulting to search window name, class, and classname
#35651718:src/App.vue
#48234696:vue3_admin_template – p021-element-plus.md
xdotool windowactivate 35651718
#XGetWindowProperty[_NET_WM_DESKTOP] failed (code=1)  #激活失败

 wmctrl -a  "src/App.vue"  #激活失败



```