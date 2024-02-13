#!/bin/bash

# https://gist.github.com/gibatronic/44073260ffdcbd122e9520756c8e35a1?permalink_comment_id=3893973#gistcomment-3893973

_npx() {
  local dir=$(pwd -P)
  while [[ -n "$dir" ]]; do
    if [[ ! -d $dir/node_modules/.bin ]]; then
      dir=${dir%/*}
      continue
    fi
    local execs=( `cd $dir/node_modules/.bin; find -L . -type f -executable` )
    execs=( ${execs[@]/#.\//} )
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "${execs[*]}" -- "$cur" ) )
    break
  done
}

complete -F _npx npx


#使用方法：
#cd /web_ui/vue3_admin_template #进入到项目目录
#source npx_autocomplete.sh #载入此脚本
#npx <tab><tab> #会收到提示命令列表