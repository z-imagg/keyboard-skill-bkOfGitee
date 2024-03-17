#!/usr/bin/env bash


usage='su - g -c "bash /home/g/shutdown-gitea.sh"'

[[ "_$(whoami)" == "_g" ]] ||  {  echo "请你切换到用户g，再执行此脚本。例子用法【${usage}】,建议别名【alias SG='${usage}'】" ; exit 3 ;}

#echo "脚本准开头， \$0==【$0】, whoami==【$(whoami)】"
cd /home/g/
#/home/g/gitea-1.21.2-linux-arm64

#列出目录/home/g/下第一个以gitea-开头的可执行文件的名字，不要全路径
GiteaF=$(basename $(find $(pwd) -maxdepth 1 -type f -name 'gitea-*' -executable | head -n 1))
#GiteaF==gitea-1.21.2-linux-arm64

#若已启动，则关闭进程
{ PID=$(pidof ${GiteaF})  &&   echo -n  "关闭中...【${GiteaF}】,PID=【${PID}】," && ./${GiteaF} manager shutdown && echo "已关闭" ;} || \
#注意上一行末尾的续行符号\后不能有任何多余字符，空格也不能有，否则语法错误。 
# 且夹在续行符号\和紧跟着的下一条命令之间的这几行注释 的#前不能有任何字符，空格也不能有，否则语法错误。
#否则（即未启动） 只打印消息    
{ echo "【未启动 ${GiteaF}】"   ;} 
