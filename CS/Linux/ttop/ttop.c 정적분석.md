## ttop.c


### CPU Usage 계산하기
- cpu 사용량을 계산하려면 다음과 같은 정보가 필요하다.
```
1. 시스템이 켜져있던 시간 (upTime): /proc/uptime [#1 output]
2. User 코드 실행시간 (uTime): /proc/[PID]/stat [#14 output]
3. Kernel 코드 실행시간 (sTime): /proc/[PID]/stat [#15 output]
4. Children CPU가 User 코드를 실행하는 동안 대기한 시간 (cuTime): /proc/[PID]/stat [#16 output]
5. Children CPU가 Kernel 코드를 실행사는 동안 대기한 시간 (csTime): /proc/[PID]/stat [#17 output]
6. Process가 시작한 시간 (startTime): /proc/[PID]/stat [#22 output]

```
- `/proc/PID/stat`에 출력되는 time은 모두 **clock tick 단위**이다.
- totalTime = uTime + sTime
- processUptime(프로세스가 생성되어 있던 시간) : upTime - (startTime / Hertz)
                                        = upTime - (startTime / 100)    // Arm은 보통 100Hz, Intel은 보통 1000Hz
- 클럭 속도 확인하는 법 : `/proc/cpuinfo`의 `cpu MHz` 확인
 * 클럭 속도는 항상 일정하지 않다. 고성능을 요구할 땐 일시적으로 오버클럭킹을 이용해 클럭 속도를 높이기도 한다.

- cpuUsage = 100 * ((totalTime / Hertz) / processUpTime)
- Application 실행 후 평균 CPU Usage

- 컴퓨터 부품들은 클럭 신호에 맞춰 움직이고, CPU는 명령어 사이클이라는 정해진 흐름에 맞춰 명령어를 실행한다.
- 클럭 속도는 Hz 단위로 측정. 1초에 클럭이 몇 번 반복되었는지 나타냄.
- 1초에 한 번 똑딱하면 1Hz. 1초에 100번 반복되면 100Hz


출처 : https://mkblog.co.kr/linux-android-cpu-usage-calculation/

<br>

### main
```
  memTotal = get_mem_total();  //전체 물리 메모리 크기
	hertz = (unsigned int)sysconf(_SC_CLK_TCK);	//os의 hertz값 얻기(초당 context switching 횟수)
	now = time(NULL);

	memset(cpuTimeTable, (unsigned long)0, PID_MAX);

	myPid = getpid();			//자기 자신의 pid

	char pidPath[FNAME_LEN];
	memset(pidPath, '\0', FNAME_LEN);
	sprintf(pidPath, "/%d", myPid);

	strcpy(myPath, PROC);			  //자기 자신의 /proc 경로 획득
	strcat(myPath, pidPath);

	getTTY(myPath, myTTY);			//자기 자신의 tty 획득
	for(int i = strlen(PTS); i < strlen(myTTY); i++)
		if(!isdigit(myTTY[i])){
			myTTY[i] = '\0';
			break;
		}

	myUid = getuid();			//자기 자신의 uid

	initscr();				  //출력 윈도우 초기화
	halfdelay(10);			//0.1초마다 입력 새로 갱신
	noecho();				    //echo 제거
	keypad(stdscr, TRUE);	//특수 키 입력 허용
	curs_set(0);			  //curser invisible

	search_proc(false, false, false, false, cpuTimeTable);
```

- `/proc/meminfo` 열어서 1행의 `memTotal` 값 읽고, Kib 단위를 Kb로 변환

- `hertz = (unsigned int)sysconf(_SC_CLK_TCK);	//os의 hertz값 얻기(초당 context switching 횟수)`
- sysconf 함수는 검색하려는 시스템 변수를 나타내는 상수를 인자로 받아서 현재 설정된 시스템 자원값을 리턴
- sysconf(3)은 초당 clock tick수
  
출처 : https://12bme.tistory.com/217   

- `memset(cpuTimeTable, (unsigned long)0, PID_MAX);`
- memset 함수 : 메모리의 값을 원하는 크기만큼 세팅하는 함수
- cpu의 이전 시각을 저장하는 해시 테이블(cpuTimeTable)을 0으로 초기화

- `pid`와 `/proc` 경로, `tty`, `uid` 획득
- `getpid()` : 실행중인 프로세스 ID 구하기

<br>

### getTTY()
- path에 대한 tty(터미널) 획득 함수
- 리눅스에서는 모든 것이 파일이기 때문에 **터미널도 파일**로 표시된다. 
- `tty` 명령어는 표준 입력에 접속된 터미널 장치의 파일명을 출력한다.
- `/dev/tty0` 같은 식으로 세션 수가 늘어날 때마다 숫자가 계속 늘어난다. 
- `/usr/bin/tty`에 있음.
- 터미널은 tty 드라이버를 통해 커널 레벨에서 프로세스 관리, 라인 편집, 세션 관리 등을 가능케 하는 서브시스템이다.
- 리눅스에는 `디바이스 파일`이라는 파일이 있다. 리눅스는 파일로써 접근하는 디바이스를 `캐릭터 장치`와 `블록 장치` 두 가지로 분류한다. 각 디바이스 파일은 `/dev`의 아래에 존재한다. 따라서 터미널을 찾고 싶으면 /dev 디렉토리를 열어서 탐색한다.

- tty 터미널 장치 : 문자별로 입력과 출력을 수행하는 문자 장치
- `/dev/tty`는 캐릭터 장치이다. (`/dev/sda`는 블록 장치)
- 캐릭터 장치는 읽기와 쓰기가 가능하지만 탐색이 되지 않는다. 대표적으로 **터미널, 키보드, 마우스**가 여기에 해당한다.
- 프로세스는 터미널에 연결되어 있음.
- 애플리케이션이 터미널의 디바이스 파일을 직접 조작하는 일은 많지 않다. 리눅스가 제공하는 셸이나 라이브러리가 직접 디바이스 파일을 다룬다. 

<br>

### fd(File Descriptor)란?
- 시스템으로부터 할당 받은 파일이나 소켓을 대표하는 정수
- 프로세스가 파일을 다룰 때 사용하는 개념. 프로세스에서 특정 파일에 접근할 때 사용하는 추상적이 값. 일반적으로 0이 아닌 값을 갖는다.
- 프로세스가 실행 중에 파일을 open하면 커널은 해당 프로세스의 fd 숫자 중 사용하지 않는 가장 작은 값을 할당해준다. 
- 프로세스가 열려있는 파일에 시스템 콜을 이용해 접근하려고 할 때, fd값을 이용해 파일을 지칭할 수 있다.
- 프로그램이 프로세스로 메모리에서 실행될 때, 기본적으로 할당되는 fd는 표준 입력이 0, 표준 출력이 1, 표준 에러가 2로 할당된다.
- `sudo ls -trn /proc/[PID]/fd` 명령어로 해당 프로세스 파일의 fd 정보 확인 가능

출처 : https://code4human.tistory.com/123  

<br>

### search_proc()
- `search_proc(false, false, false, false, cpuTimeTable);`
- util.c에 있는 /proc 디렉토리 탐색 함수

<br>

### print_ttop()
- 실질적인 계산 부분은 `print_ttop()` 함수에 있음

1. uptime 계산 부분
- get_uptime()함수로 불러온 tmUptime 값을 이용해 계산
- /proc/utmp을 열어서 user 수 확인

* uptime 명령어와 /proc/uptime 차이
- `/proc/uptime` : 시스템 가동 시간 정보 기록
- `uptime` 명령어는 초 단위가 나오지 않음. days/hours/minutes까지.
- cat /proc/uptime으로 보면 초단위로 나옴.
- /proc/uptime의 첫 번째 값이 일/시/분으로 변환 되어 uptime 명령어로 출력
- 두 번째 값은 idle time (켜져 있었지만 일은 없었던 시간)

2. load 계산
- /proc/loadavg 열어서 값 그대로 가져옴. 계산 없음.

3. Task 출력 부분
- procList의 stat 부분 확인해서 각 상태별 카운팅함

4. %CPU 부분
- tick 읽어서 tickCnt = uptime * hertz 로 부팅 후 현재까지 일어난 문맥 교환 횟수 계산.
- 현재 틱수 - 이전 값 해서 퍼센트로 변환해 저장

5. %Mem 부분
-  meminfo 정보 읽어와서 아래와 같이 계산

    memUsed = memTotal - memFree - buffers - cached - sReclaimable
	swapUsed = swapTotal - swapFree
    buff/cahce = buffers + cached + sReclaimable

