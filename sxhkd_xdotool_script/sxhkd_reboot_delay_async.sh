#!/bin/bash

set -x
{ ( sleep 2 &&  sxhkd & ) & } && kill $(pidof sxhkd)

set +x
{ ( sleep 2.3 && echo "sxhkd's PID: 【$(pidof sxhkd)】" ) & }