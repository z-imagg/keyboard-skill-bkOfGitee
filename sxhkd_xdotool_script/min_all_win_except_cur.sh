#!/bin/sh

#最小化非当前窗口

# 1.保存当前窗口id
curr_win_id=$(xdotool getactivewindow )

# 2.最小化所有窗口
wmctrl -k on

# 3.最大化当前窗口尺寸(估计不需要这一步)
#wmctrl -ir   ${curr_win_id}   -b add,maximized_vert,maximized_horz


# 4. 激活当前窗口
wmctrl -i -a ${curr_win_id}
#或#xdotool windowactivate   ${curr_win_id}
