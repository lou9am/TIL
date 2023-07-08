## header.h
- 필요한 헤더파일, 매크로 상수들을 정의
- 매크로 상수의 경우, 절대 경로라던가 파일 안에서 인덱스나 row들, column 문자들
- 눈여겨 볼 것은 `myProc`이라는 구조체 & `/proc` 하위 디렉토리 및 파일들에서 어떤 인덱스 또는 행의 값을 읽어오는지

### myProc struct
- 프로세스를 추상화 한 구조체
- 출력할 항목들과 계산에 필요한 항목들

```
//process를 추상화 한 myProc 구조체
typedef struct{
	unsigned long pid;
	unsigned long uid;			//USER 구하기 위한 uid
	char user[UNAME_LEN];		//user명
	long double cpu;			//cpu 사용률
	long double mem;			//메모리 사용률
	unsigned long vsz;			//가상 메모리 사용량
	unsigned long rss;			//실제 메모리 사용량
	unsigned long shr;			//공유 메모리 사용량
	int priority;				//우선순위
	int nice;					//nice 값
	char tty[TTY_LEN];			//터미널// /proc/meminfo 에서의 row
#define MEMINFO_MEM_TOTAL_ROW 1
#define MEMINFO_MEM_FREE_ROW 2
#define MEMINFO_MEM_AVAILABLE_ROW 3
#define MEMINFO_BUFFERS_ROW 4
#define MEMINFO_CACHED_ROW 5
#define MEMINFO_SWAP_TOTAL_ROW 15
#define MEMINFO_SWAP_FREE_ROW 16
#define MEMINFO_S_RECLAIMABLE_ROW 24
	char stat[STAT_LEN];		//상태
	char start[TIME_LEN];		//프로세스 시작 시각
	char time[TIME_LEN];		//총 cpu 사용 시간
	char cmd[CMD_LEN];			//option 없을 경우에만 출력되는 command (short)
	char command[CMD_LEN];		//option 있을 경우에 출력되는 command (long)
	
}myProc;
```

- vsz : 가상 메모리 사이즈 (bytes)
- rss : Resident Set Size. 실제 메모리에서 프로세스의 페이지 수
- shr : 공유 메모리 크기
- tty : tty 명령어는 standard input에 연결된 터미널의 파일 이름을 출력하는 명령어. 출력 수단이 터미널인지 확인하는 용도.
아무런 파일이 탐지되지 않았다면, 스크립트의 일부로 실행 중이거나 파이프라인에서 실행 중이라는 뜻이다.

### 읽을 파일
주로 읽어 오는 파일은 아래와 같다.
1. `/proc/pid/stat`
2. `/proc/pid/status`
3. `/proc/stat`
4. `/proc/meminfo`
5. `/proc/uptime`

하나씩 살펴보면,

### 1. /proc/pid/stat
- 각 pid에 해당되는 프로세스의 상태 정보
- 시스템 타이머의 주기에 맞추 갱신된다.
```
// /proc/pid/stat에서의 idx
#define STAT_PID_IDX 0
#define STAT_CMD_IDX 1
#define STAT_STATE_IDX 2
#define STAT_SID_IDX 5
#define STAT_TTY_NR_IDX 6
#define STAT_TPGID_IDX 7
#define STAT_UTIME_IDX 13
#define STAT_STIME_IDX 14
#define STAT_PRIORITY_IDX 17
#define STAT_NICE_IDX 18
#define STAT_N_THREAD_IDX 19
#define STAT_START_TIME_IDX 21
```

- `sid` : 프로세스의 session ID
- `tty_nr` : The controlling terminal of the process.
- `tpgid` : The ID of the foreground process group of the controlling terminal of the process.
- `utime` : 프로세스가 user mode에서 스케줄링 된 시간 (clock ticks로 측정됨)
- `stime` : 프로세스가 kernel mode에서 스케줄링 된 시간


### 2. /proc/pid/status
- 18-19행, 22행, 24행
```
// /proc/pid/status에서의 row
#define STATUS_VSZ_ROW 18
#define STATUS_VMLCK_ROW 19
#define STATUS_RSS_ROW 22
#define STATUS_SHR_ROW 24
```
- `Vmsize` : 프로세스에 할당된 swap 메모리 + 물리 메모리의 합. swap 사용량만을 산출하기 위해서는 Vmsize - VmRSS를 하면 된다.
- `vmlck` : 가상 메모리에서 스왑아웃 될 수 없는 영역에 대한 메모리의 크기


### 3. /proc/stat
- 1~8번째 인덱스
- cpu 사용량 부분에 필요
- 첫 줄은 모든 cpu 코어의 합이며, 두 번째 줄부터 각 코어마다 한 줄씩 출력됨.
- 누적 시간으로 출력되기 때문에 **usage를 나타내려면 일정 간격을 두고 측정**해야 한다.
- 각 필드는 리눅스의 시간 표시 단위인 jiffy로 나타낸다.
* `jiffy` : system timer interrupt에 의한 one tick을 나타내는 단위. 기본적으로 100Hz(0.01초)

```
// /proc/stat 에서의 idx
#define CPU_STAT_US_IDX 1
#define CPU_STAT_SY_IDX 2
#define CPU_STAT_NI_IDX 3
#define CPU_STAT_ID_IDX 4
#define CPU_STAT_WA_IDX 5
#define CPU_STAT_HI_IDX 6
#define CPU_STAT_SI_IDX 7
#define CPU_STAT_ST_IDX 8
```

### 4. /proc/meminfo
- 1-5행, 15-16행, 24행
- 메모리 계산에 필요
```
// /proc/meminfo 에서의 row
#define MEMINFO_MEM_TOTAL_ROW 1     // 물리적인 메모리 사이즈
#define MEMINFO_MEM_FREE_ROW 2      // 시스템에 의해 사용되지 않고 남아있는 물리 메모리 양
#define MEMINFO_MEM_AVAILABLE_ROW 3
#define MEMINFO_BUFFERS_ROW 4       // 파일 버퍼를 위해 사용되는 물리적인 메모리 양
#define MEMINFO_CACHED_ROW 5        // RAM 중에서 캐시 메모리로 사용되는 양
#define MEMINFO_SWAP_TOTAL_ROW 15   // 물리적인 swap 메모리의 총량
#define MEMINFO_SWAP_FREE_ROW 16    // swap 메모리의 free 양
#define MEMINFO_S_RECLAIMABLE_ROW 24
```

- `Sreclaimable` : 회수 가능한 슬랩 페이지
* `Slab` : 커널이 내부적으로 사용하는 영역
- 커널 역시 프로세스의 일종이기 때문에 메모리를 필요로 하고, 다른 프로세스들보다 특별한 방법으로 메모리를 할당받아서 사용하는데 이 때 쓰이는 공간이 Slab이다.
- Sreclaimable은 Slab 영역 중 재사용될 수 있는 영역이다. 캐시 용도로 사용하는 메모리들이 주로 여기에 포함되며, 해제되어 프로세스에 할당이 가능하기 때문에 사용가능한 메모리 양을 계산할 때 사용된다.
- `Sunreclaim` : 커널이 현재 사용 중인 영역이므로 해제해서 다른 용도로 사용이 불가능함.
