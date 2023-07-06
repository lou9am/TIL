`uname -r` : 커널 버전
`lsb_release - a` : 우분투 버전
`top -v | head -l` : 탑 명령 버전

top 명령어 내용 파악하기

1. 시스템 정보
- 흰색 바 위의 5줄

1) 시간 정보 = 현재 시간, 컴퓨터 실행시간 (`uptime` 명령과 동일)
`date` 명령어로 확인한 시간 정보가 앞에 있음.
`uptime -p` 명령어로 확인한 `uptime` 정보
2) load average : 시스템 부하정도를 나타내는 (cpu 부하)
                    1분, 5분, 15분 시스템 부하평균값(EMA; 지수평균이동값)
                    'R' 실행중인 프로세스
                    'D' 디스크 I/O 처리완료를 기다리는 프로세스


예시 : cpu 싱글코어 기준 (load avg 예시)
1.0 -> 100% (로드가 꽉 찼다. 여유는 없지만 돌아는 가는 상황)
0.5 -> 50% (어느 정도 여유 있다)
1.7 -> 170% (부하가 너무 많아 시스템 확인 필요!)

`-nproc` 명령어로 코어 개수 확인

4개 코어 기준으로는 4.0이어야 100%임. 3.0이면 75% 찼다.

3) Task(프로세스) 정보 : 거시적인 관점에서 프로세스 정보
total / run / sleep (개수가 왜 안맞을까? 세부적인 정보를 보면 I인 상태가 카운팅 안되어서!)
Idle 상태 : user 프로세스, kernel task 멈춰있을 , 슬립 중인 kernel thread
sleep 상태의 예시 : 네트워크 I/O 처리대기

`ps -eo cmm,state` 명령어 : 프로세스 네임과 상태를 함께 확인 가능
`ps -eo cmm,state | grep I` : idle인 상태를 볼 수 잇음
`ps --no-headers -eo cmm,state | grep I | wc -l` : idle 상태 개수 나옴
`python -c "print (idle인거) + (sleep중인거) + (run중인거)"`  = total 과 동일

top 화면에서 ctrl + z하면 스탑 시그널 보내서 멈춤. stopped가 늘어남.
`fg` 명령어(foreground)로 멈춘 프로세스 다시 살릴 수 있음

zombie : 자식 프로세스가 먼저 종료된 경우. 부모 프로세스가 기다렸다가 자원 해지를 해주면 좀비 안됨. way system call 사용 안 하면 자식 프로세스에 대한 자원이 정리되지 않아서 좀비 프로세스로 남아있는 현상 발생

4) cpu 사용률 % (다 더하면 100% 나옴)
us : user mode(높은 우선순위 nice 0또는 음수)
- 디폴트 우선순위라고 하는 친절도가 낮기 때문에 높은 우선순위의 프로세스
- 높은 우선순위의 프로세스가 CPU 얼마나 점유했는지
sy : kernel mode

ni : user mode(낮은 우선순위 nice 양수)
- 낮은 우선순위의 프로세스가 CPU 얼마나 점유?

id : idle (시스템이 얼마나 여유롭냐?)
- 아무것도 안 하는 상태. idle 높으면 돌고 있는 프로세스 별로 없어서 여유롭다

wa : I/O wait (처리완료를 기다린 시간)
- 처리 요청 후 완료될 때까지 시간.
- 이 수치가 높으면 처리가 지연되고 있음. I/O요청이 왜 처리 안되는지 확인해보기. 트래픽이 너무 많으면 벌어질 수 있음

hi : hard irq (인터럽트 전반부처리(빠른처리))
- 인터럽트 처리 위해 CPU가 얼마나 처리됐는가
- 빨리 처리해야되는 것
- 인터럽트 많이 발생하면 퍼센티지 올라감

si : soft irq (인터럽트 후반부처리(지연처리)
- 인터럽트 처리 위해 CPU가 얼마나 처리됐는가
- 나중에 처리해도 되는 것
- 인터럽트 많이 발생하면 퍼센티지 올라감

st : 가상 cpu 구동 (guest os를 위한 VM처리)
- 가상 cpu를 구동하기 위해 얼마나 cpu를 사용했느냐?

5) MEM 사용율 % (free 명령 동일결과)
total : 총 메모리 공간 KB
free : 남는 메모리 공간 KB
used : 사용중인 메모리 공간 KB
buff/cache : 디스크에 있는 내용을 메모리에 캐시 KB

free + used + buff/cache = total
`free -h` 명령어 사용 : KB가 아닌 G, M 사이즈로 메모리 확인 가능함.

available : 프로세스가 처음 시작 시 사용가능한 메모리 공간 KB
            (회수하면 얻을 수 있는 공간 포함)
- 만약에 디스크에 원래 적혀야할 내용이 메모리가 있다는 거는 회수가 가능. 회수해서 다시 디스크에 적으면 메모리 공간 확보가능.
- free와 캐시의 일부분을 포함해서 available수치 계산 가능

swap : 메모리의 내용을 저장해둘 수 있는 Disk 공간 KB

`lsblk /dev/sda` 명령어 : swap 영역이 몇 기가, 메모리 내용을 적을 수 있는 특수한 공간. 메모리 공간 절약 가능

스왑이 많다 -> 안 좋다
스왑이 발생 -> 리눅스 커널이 메모리 중에 안 쓰는 메모리를 전부 디스크에 내림 - >그과정에서 io (디스크 쓰기 읽기) 행위 발생 -> 디스크가 ram보다 느리기 때문에 안 좋음 -> swap 빈번하면 wa도 올라감

free가 많아도 swap이 존재하는 이유 : 메모리가 없으면 스왑을 쓰는 게 아님. 리눅스 커널 입장에선 사용자 별로 사용할 수 있는 메모리 양이 정해져있음. 메모리양이 과하게 오바하면 스왑 발생. 프로세스 별로 한 번 쓸수있는 메모리 정해져있음. 

buffers와 cached
최초 ls결과를 메모리에 가지고 있음.
버퍼랑 캐시는 높아져도 괜찮음. free 메모리 없으면 버퍼랑 캐시 비우고 가져오면 되기 때문에 괜찮음.

예를 들어 load가 걸렸을 때 top은?
점점 load average가 올라감. (백분율아님) -> 좀비 프로세스 생김 -> 프리 메모리 작아짐
제일 먼저 보는 건 load average를 봄. 갑자기 느려진 경우는 (1분 단위) 현시점 접속이 과하구나.
만약 접속은 과하지 않은데 5분, 15분 단위가 높다 -> 정기적으로 퍼포먼스가 떨어졌구나
free 여유 있는데 스왑 많다 -> 어플리케이션 중에 메모리 과하게 점유하는 놈이 있구나 (특정한 놈이 열내고 있구나)



2. 프로세스 세부 정보 (미시적)





### CPU사용률 계산하는 방법

cat /proc/stat
grep 'cpu ' /proc/stat
grep 'cpu ' /proc/stat | awk '{usage=($4)*100/($2+$3+$4+$5+$6+$7+$8+$9+$10+$11)} END {print usage "%"}'


### how to calculate memory utilization in linux using free command

Memory Utilized = ((total - free)/total * 100)%
used = total - free - buffers - cache


buff와 cache 차이 : buff는 파일 시스템의 메타 데이터와 관련된 블록을 저장하는 캐시
캐시는 파일의 내용을 저장하고 있는 캐시


ps명령어를 동적으로 보는 게 top

proc/meminfo에 cpu,memory, distk등 시스템 정보들 확인 가능
free가 meminfo 정보 가져오는 거
