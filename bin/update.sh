#!/usr/bin/env bash

GREEN='\033[32m'
BLUE='\033[34m'
WHITE="\033[1;37m"

pkg_updates(){
if command -v pacman &> /dev/null
then
    updates=$(checkupdates | wc -l)
elif command -v xbps-install &> /dev/null
then
    updates=$(doas xbps-install -Syun | wc -l)
fi
  if [ $updates == 0 ]; then  
      echo -e "${GREEN} ${WHITE}Fully Updated"
  else
      echo -e "${BLUE} ${WHITE}$updates"
  fi

}
echo "$(pkg_updates)"
