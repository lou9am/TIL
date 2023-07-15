#!/bin/bash

# 로그 파일을 병합할 디렉토리
log_directory="/run"

# 병합할 로그 파일들
log_files=("log1" "log2" "log3" "log4" "log5")

# 로그 파일들을 하나로 병합하여 저장할 디렉토리 및 파일명
output_directory="/run"
merged_log_file="log_all.log"

# 최대 파일 크기 (1MB)
max_file_size=1000000

# 대상 디렉토리
target_directory="/home/pi/log"

# 파일 크기가 1MB 이상인지 확인
function is_file_size_over_limit() {
  local file="$1"
  [ "$(stat -c%s "$file")" -ge "$max_file_size" ]
}

# 로그 파일 실시간 병합 및 크기 확인
while true; do
  # 로그 파일들을 하나로 병합
  cat "${log_directory}/${log_files[@]}" >> "$merged_log_file"

  # 파일 크기가 1MB 이상인지 확인
  if is_file_size_over_limit "$merged_log_file"; then
    # 대상 디렉토리에 log_all.log 파일이 있는 경우 기존 파일을 log_all_old.log로 변경
    if [ -f "$target_directory/$merged_log_file" ]; then
      mv "$target_directory/$merged_log_file" "$target_directory/log_all_old.log"
      echo "기존의 log_all.log 파일을 log_all_old.log로 변경하였습니다."
    fi

    # log_all.log 파일을 대상 디렉토리로 복사
    cp "$merged_log_file" "$target_directory/$merged_log_file"
    echo "log_all.log 파일이 $target_directory 디렉토리에 저장되었습니다."

    # 로그 파일 초기화
    > "$merged_log_file"

    # log1, log2, log3, log4, log5 파일 삭제
    rm "${log_directory}/${log_files[@]}"
    echo "log1, log2, log3, log4, log5 파일이 삭제되었습니다."
  else
    sleep 1
  fi
done
