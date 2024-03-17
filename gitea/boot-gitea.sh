#!/usr/bin/env bash


usage='su - g -c "bash /home/g/boot-gitea.sh"'

function PrintUsage{
#在stderr中打印人类可读的提示信息
echo -e "\e[1;31m『stderr』【命令用法错误，此命令的正确勤快用法『${usage}』已经放入stdout，正确偷懒用法为『\$(bash ${usage})』】\e[0m" >&2
#在stdout中打印单纯的命令调用语句, 使得 直接 $(bash boot-gitea.sh) 即可正确执行此命令
echo -n "${usage}"
}

[[ "_$(whoami)" == "_g" ]] ||  {  PrintUsage ; exit 3 ;}

#echo "脚本准开头， \$0==【$0】, whoami==【$(whoami)】"
cd /home/g/
#/home/g/gitea-1.21.2-linux-arm64

#列出目录/home/g/下第一个以gitea-开头的可执行文件的名字，不要全路径
GiteaF=$(basename $(find $(pwd) -maxdepth 1 -type f -name 'gitea-*' -executable | head -n 1))
#GiteaF==gitea-1.21.2-linux-arm64

#若已启动，只打印消息
{ PID=$(pidof ${GiteaF})  &&   echo "已启动【${GiteaF}】,PID=【${PID}】"  ;} || \
#注意上一行末尾的续行符号\后不能有任何多余字符，空格也不能有，否则语法错误。 
# 且夹在续行符号\和紧跟着的下一条命令之间的这几行注释 的#前不能有任何字符，空格也不能有，否则语法错误。
#否则（即未启动） 做启动逻辑，    
#                          注意 "(  nohup  命令  & )" 中的 圆括号、&是相互配合的， 即 在 子进程中以后台任务执行该命令， 圆括号==子进程，
{ echo "【启动 ${GiteaF}】..." ; ( nohup ./${GiteaF} web & ) ;  pid=$! ; echo "成功启动【${GiteaF}】,PID=【${PID}】" ;} 
