#!/bin/bash

#xdotool : bash 自动完成 脚本 
#来自 chatgpt-3.5-turbo :  https://vip.easychat.work/#/?settings={%22endpoint%22:%22https://api.nextway.top/api/openai%22}

_xdotool_complete() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="getactivewindow getwindowfocus getwindowname getwindowpid getwindowgeometry getdisplaygeometry search selectwindow help version behave behave_screen_edge click getmouselocation key keydown keyup mousedown mousemove mousemove_relative mouseup set_window type windowactivate windowfocus windowkill windowclose windowmap windowminimize windowmove windowraise windowreparent windowsize windowunmap set_num_desktops get_num_desktops set_desktop get_desktop set_desktop_for_window get_desktop_for_window get_desktop_viewport set_desktop_viewport exec sleep"

    if [[ ${prev} == "xdotool" ]]; then
        COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
        return 0
    fi
}

complete -F _xdotool_complete xdotool

