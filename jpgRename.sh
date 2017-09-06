#!/bin/bash

lastPath=""
for filename in $(find . -depth)
do 
  if [[ ${filename} == *.jpg* && ${filename} == *./* ]]; then
    filePath=${filename/\.\//}
    pathToFile="./"
    IFS='/' read -r -a array <<< "$filePath"
    newPath=""
    for index in "${!array[@]}"; do
      segment="${array[index]}"
      if [[ ${segment} != *.jpg* ]]; then
        newPath+="${segment,,}-"
        pathToFile+="$segment/"
      fi
    done
    if [ "$lastPath" == "$newPath" ]; then
      inc=$((inc+1))
     else
      inc=1
    fi
    newFileName="${newPath}${inc}.jpg"
    pathToFile+="$newFileName"
    mv ${filename} ${pathToFile}
    lastPath="$newPath"
  fi
done
