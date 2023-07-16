#!/bin/bash

thread_ids=()
logger_pid=""

# intern.c 실행
./intern &

sleep 5

thread_ids+=$(pgrep -P $$)

./Logger &
logger_pid=$!

while true
do
        for thread_id in "${thread_ids[@]}"
        do
                thread_status=$(ps -o stat= -p $thread_id)

                if [[ "$thread_status" == "T" ]]; then
                        echo "Thread $thread_id is not running. Kill all."

                        kill ${thread_ids[@]} $logger_pid
                        exit 1

                fi
        done

        sleep 1
done
