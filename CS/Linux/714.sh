#!/bin/bash

input_directory="/path/to/input_directory"
output_file="/path/to/output_file"

# 파일 사이즈가 1MB 이상인 파일을 찾아서 병합하는 함수
merge_files() {
  # input_directory에서 파일 사이즈가 1MB 이상인 파일 리스트를 가져옴
  large_files=$(find "$input_directory" -type f -size +1M)
  
  if [ -n "$large_files" ]; then
    # 파일을 병합하기 전에 output_file이 이미 존재하는지 확인하고, 있다면 삭제
    if [ -f "$output_file" ]; then
      rm "$output_file"
    fi
    
    # 파일을 병합
    cat $large_files > "$output_file"
    
    echo "파일을 병합했습니다: $output_file"
  fi
}

while true; do
  # input_directory에서 파일 사이즈가 1MB 미만인 파일 개수를 가져옴
  small_file_count=$(find "$input_directory" -type f -size -1M | wc -l)
  
  if [ "$small_file_count" -eq 0 ]; then
    merge_files
    break
  else
    echo "파일 사이즈가 1MB 미만인 파일이 존재합니다. 대기 중..."
    sleep 1
  fi
done
