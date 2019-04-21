#!/bin/bash
echo -en "Auto-detecting OS environment... \033[0;31m"
WHICH=$(which docker.exe)
echo -ne "\033[0m" 
if [[ $WHICH ]]; then
    echo 'Running in Windows Mode, calling docker.exe'
    DOCKEREXE=.exe
else
    echo 'Running in Linux mode, calling the pathed docker bin'
    DOCKEREXE=
fi
echo ''