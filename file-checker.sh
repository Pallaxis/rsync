#!/bin/bash

function confirm() {
  while true; do
    read -p "Yes(Passed)/No(Failed) " -r yn
    case $yn in
      [Yy] ) return 0;;
      [Nn] ) return 1;;
      * ) echo "Invalid key pressed";;
    esac
  done
}

declare -a videos_array_passed
declare -a videos_array_failed
declare -a videos_array_current_passed

while read -r line; do
  videos_array_passed+="$line "
done < "passed"

for video in *.webp; do
  IFS=" "
  if [[ "${IFS}${videos_array_passed[*]}${IFS}" =~ "${IFS}${video}${IFS}" ]]; then
    continue
  fi
  unset IFS

  $(firefox ${video})
  if confirm; then
    echo "true"
    videos_array_current_passed=("${videos_array_current_passed[@]}" "$video")
  else         
    echo "false"
    videos_array_failed+="${video} "
  fi
done
echo $videos_array_current_passed
{ [ "${#videos_array_current_passed[@]}" -eq 0 ] || printf "%s\n" "${videos_array_current_passed[@]}"; } >> passed
#echo "failed videos " $videos_array_failed
#echo "passed videos " $videos_array_passed
