#!/bin/bash

# 스레드 ID 저장 배열
thread_ids=()

# Logger.sh 스크립트의 프로세스 ID 저장 변수
logger_pid=""

# 스레드 생성 및 백그라운드로 실행
./intern.c &

sleep 1

# 스레드의 프로세스 ID 저장
thread_ids+=($!)

# Logger.sh 실행 및 프로세스 ID 저장
./Logger.sh &
logger_pid=$!

# 모든 스레드 및 Logger.sh 모니터링
while true
do
    # 스레드 상태 확인
    for thread_id in "${thread_ids[@]}"
    do
        # 스레드 상태 확인 명령
        thread_status=$(ps -o stat= -p $thread_id)

        # 스레드 상태가 정상적이지 않은 경우
        if [[ "$thread_status" != "R" ]]; then
            echo "Thread $thread_id is in abnormal state. Killing all threads and Logger.sh."
            
            # 모든 스레드 및 Logger.sh 종료(kill)
            for thread_id in "${thread_ids[@]}"
            do
                kill $thread_id
            done
            kill $logger_pid
            
            # 스크립트 종료
            exit 1
        fi
    done

    # 1초 대기
    sleep 1
done
