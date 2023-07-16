#!/bin/bash

log_directory="/run"
#log_files=("log1" "log2" "log3" "log4" "log5")
log_files=$(find "$log_directory" -maxdepth 1 -type f -regex ".*/log[0-9]+")

merged_log_file="log_all.log"

max_file_size=1000000

target_directory="/home/guest/log"


while true; do
  # log1~log5 파일이 존재하면 병합
  for file in "${log_directory}"/log{1..5}; do
          if [ -f "$file" ]; then
                  cat "$file" >> "$log_directory/$merged_log_file"
          fi
  done

  # 병합 파일의 크기 확인
  file_size=$(wc -c < "/run/log_all.log")

  # 파일 크기가 1MB 이상이면
  if [ "$file_size" -ge "$max_file_size" ]; then

    # -f : 파일이 존재하고 일반 파일이면 True
    if [ -f "$target_directory/$merged_log_file" ]; then
      # 같은 이름 파일이 이미 존재하면
      mv "$target_directory/$merged_log_file" "$target_directory/log_all_old.log"
      echo "기존 파일을 old로 변경"
    fi

    # run에서home/pi/log로 이동
    cp /run/log_all.log /home/guest/log/log_all.log
    # cp "$merged_log_file" "$target_directory/$merged_log_file"
    echo "log_all.log 파일이 $target_directory 디렉토리에 저장"

    # 기존 파일은 삭제
    cat /dev/null > /run/log_all.log

    # log1 ~ log5도 삭제
    rm /run/log1 /run/log2 /run/log3 /run/log4 /run/log5
    echo "log1, log2, log3, log4, log5 파일 삭제"

  # 파일 크기가 1MB보다 작으면
  else
    sleep 1
  fi
done
