## util.c의 함수들

### get_uptime 함수
- `/proc/uptime`의 첫 번째 double을 읽음

### get_mem_total 함수
- `/proc/meminfo`에서 전체 물리 메모리 크기 얻는 함수
- 1행의 `memTotal` 읽어 온 후, Kib단위를 Kb로 변환

* 물리 주소 : 정보가 실제로 저장된 메모리 하드웨어상의 주소
* 논리 주소 : CPU와 실행 중인 프로그램이 사용하는 주소
* MMU : 논리 주소와 물리 주소 간의 변환을 담당하는 CPU와 주소 버스 사이에 위치한 메모리 관리 장치.<br>
`논리 주소 + 베이스 레지스터 = 물리 주소`
* 베이스 레지스터 : 프로그램의 가장 작은 물리 주소, 프로그램의 첫 물리 주소. 논리 주소는 프로그램의 시작점으로부터 떨어진 거리

### add_proc_list 함수 (중요)
- pid 디렉토리 안의 파일들을 이용해 `myProc` 완성하는 함수
- pid 획득
- 최상위 프로세스(systemd)일 경우와 아닐 경우 구분

    1. %cpu 계산하는 부분
    - 이전에 실행된 내역이 있을 경우 이전 실행 이후 값 사용
    - 없을 경우 process 시작 시각 이후 값 사용
    - 현재까지의 프로세스 사용 내역 저장

    ```if(!update)
		cpu = ((totalTime) / hertz) / (long double)(uptime-(startTime/hertz)) * 100;	//%cpu 계산
	if(isnan(cpu) || isinf(cpu) || cpu > 100 || cpu < 0)	// error 처리
		proc.cpu = 0.0;
	else
		proc.cpu = round_double(cpu, 2);	// 소숫점 아래 3자리에서 반올림
    ```

    2. %mem 계산하는 부분
    - `/proc/pid/status` 경로 획득 -> 18행까지 read
    - 메모리 정보가 있을 경우 `vsz, vmLck, rss, shr` 값 획득해 메모리 계산

    ```long double mem = (long double)proc.rss / memTotal * 100;	//%mem 계산
		if(isnan(mem) || isinf(mem) || mem > 100 || mem < 0)	// error 처리
			proc.mem = 0.0;
		else
			proc.mem = round_double(mem, 2);	//소숫점 아래 3자리에서 반올림
    ```

    3. State 확인하는 부분
    - `tty, priority, nice, state` 획득해 상태를 확인

    4. Start 획득 부분
    ```unsigned long start = time(NULL) - uptime + (startTime/hertz);
	struct tm *tmStart= localtime(&start);
	if(time(NULL) - start < 24 * 60 * 60){
		strftime(proc.start, TIME_LEN, "%H:%M", tmStart);
	}
	else if(time(NULL) - start < 7 * 24 * 60 * 60){
		strftime(proc.start, TIME_LEN, "%b %d", tmStart);
	}
	else{
		strftime(proc.start, TIME_LEN, "%y", tmStart);
	}
```

    5. TIME 획득 부분
    ```unsigned long cpuTime = totalTime / hertz;
	struct tm *tmCpuTime= localtime(&cpuTime);
	if(!isPPS || (!aOption && !uOption && !xOption))	//ttop이거나 pps에서 옵션이 없을 경우
		sprintf(proc.time, "%02d:%02d:%02d", tmCpuTime->tm_hour, tmCpuTime->tm_min, tmCpuTime->tm_sec);
	else
		sprintf(proc.time, "%1d:%02d", tmCpuTime->tm_min, tmCpuTime->tm_sec);

	sscanf(statToken[STAT_CMD_IDX], "(%s", proc.cmd);	//cmd 획득
	proc.cmd[strlen(proc.cmd)-1] = '\0';	//마지막 ')' 제거
```

### search_proc
- `/proc` 디렉토리 탐색하는 함수
- `/proc` 디렉토리 내 하위 파일들을 탐색하며 절대 경로를 저장하고, stat을 획득한다.
- PID 디렉토리인 경우 `procList`에 추가한다.
