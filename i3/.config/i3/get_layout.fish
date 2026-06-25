#!/usr/bin/env fish
set layout (setxkbmap -query | grep layout | awk '{print $2}')
echo $layout

