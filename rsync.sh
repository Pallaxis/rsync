#!/usr/bin/bash

Help() {
  echo "Select option 1 to choose from a list of devices to sync from."
}

License() {
  echo "Copyright (C) 2024 Henry Paradise"
  echo
  echo "This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version."
  echo
  echo "This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details."
  echo
  echo "You  should  have received a copy of the GNU General Public License  along with this program. If not, see <http://www.gnu.org/licenses/>"
  exit
}

Main() {
  PS3="Select device to download from: "
  options=("1xx.xxx.xxx.xxx" "2xx.xxx.xxx.xxx" "3xx.xxx.xxx.xxx")
  select opt in "${options[@]}"; do
    case $opt in
      "1xx.xxx.xxx.xxx")
        ip="1xx.xxx.xxx.xxx";Sync $ip;;
      "2xx.xxx.xxx.xxx")     
        ip="2xx.xxx.xxx.xxx";Sync $ip;;
      "3xx.xxx.xxx.xxx") 
        ip="3xx.xxx.xxx.xxx";Sync $ip;;
      "exit")
        break;;
      *)
        echo "invalid option $REPLY";continue;;
    esac
  done

}

Sync() {
  location=""
  while true; do
    echo "Would you like to leave default (~/Videos) or choose a location?"
    read -p "Choice: [Y] Default / [n] Choose location" yn

    if [[ $REPLY =~ ^[Yy]$ || ^$ ]]; then
      location="~/Videos"
      break
    else
      read -p "Enter location to save to: " location
      break
    fi
  done
  echo "rsync $1 $location"
  exit
}

PS3="select choice: "
options=("Devices" "Help" "License" "Quit")
select opt in "${options[@]}"; do
  case $opt in
    "Devices")
      Main;;
    "Help")
      Help;;
    "License")
      License;;
    "Quit")
      break;;
    *)
      echo "invalid option $REPLY";continue;;
  esac
done
