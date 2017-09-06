#!/bin/bash

lastPath=""
find . -type f -name '*.*' -print0 | while IFS= read -r -d '' filename; do
  if [[ $filename == *.jpg* || $filename == *.JPG* ]] && [[ ${filename} == *./* ]]; then
    filePath=${filename/\.\//}
    pathToFile="./"
    IFS='/' read -r -a array <<< "$filePath"
    newPath=""
    for index in "${!array[@]}"; do
      segment="${array[index]}"
      if [[ ${segment} != *.jpg* && ${segment} != *.JPG* ]]; then
        pathToFile+="$segment/"
        segment=${segment/ /-}
        segment=${segment,,}
        newPath+="$segment-"
      fi
    done
    if [ "$lastPath" == "$newPath" ]; then
      inc=$((inc+1))
     else
      inc=1
    fi
    newFileName="${newPath}${inc}.jpg"
    pathToFile+="$newFileName"
    mv "$filename" "$pathToFile"
    lastPath="$newPath"
  fi
done
