#!/bin/sh

#参考: http://giteaz:3000/misc/sxhkd-xtotool--warpd--VimiumC/src/branch/main/sxhkd-xdotool.md#%E5%B0%86%E5%BD%93%E5%89%8D%E7%AA%97%E5%8F%A3%E7%A7%BB%E5%8A%A8%E5%88%B0%E5%8F%A6%E4%B8%80%E4%B8%AA%E6%98%BE%E7%A4%BA%E5%99%A8%E7%9A%84%E5%90%8C%E6%A0%B7%E4%BD%8D%E7%BD%AE%E8%B0%83%E8%AF%95%E8%BF%87%E7%A8%8B


#获得当前活动窗口尺寸、位置
echo "获得当前活动窗口尺寸、位置："
set -x
eval $(xdotool getwindowgeometry --shell $(xdotool getactivewindow) )
set +x
#例子输出如下:
# WINDOW=46137351
# X=2295
# Y=288
# WIDTH=1114
# HEIGHT=680
# SCREEN=0

#人工定义 一个显示器的宽度
monitor_width=1920
echo "人工定义 一个显示器的宽度 为: $monitor_width"

#X 在 区间[0,2*monitor_width] 内，则X的另一个合法位置 X-monitor_width 或 X+monitor_width 只有一个 也在该区间内，以下代码计算X的另一个合法位置
signArr=(+1 -1)
signIdx=$(( X / monitor_width ))
newX=$(( X + signArr[signIdx] * monitor_width ))
echo "当前窗口在另一个显示器中的X坐标为【$newX】"


wmctrl -ir $active_win_id -e 0,$((newX)),$((Y)),$WIDTH,$HEIGHT
