### 22.12.30.금
- [x] 이것이 취업을 위한 코딩테스트다 with python `그리디` (86~102p)
- [x] 이것이 취업을 위한 코딩테스트다 with python `구현` (104~121p)

### 22.12.31.토 (7hrs)
- [x] 이것이 취업을 위한 코딩테스트다 with python `DFS/BFS` (124~154p)
- [x] 이것이 취업을 위한 코딩테스트다 with python `정렬` (156~184p)
- [x] 정렬의 종류와 특징 이해 <br>
- **선택정렬** : 특정 리스트에서 가장 작은 데이터 찾을 때<br>
- **삽입정렬** : 리스트가 거의 정렬되었을 때<br>
- **퀵정렬** : 이미 데이터가 정렬되어 있을 때 매우 느리게 동작<br>
- **계수정렬** : 특정 조건이 부합할 때만 사용 가능, 매우 빠름, 동일한 값을 가지는 데이터가 여러 개 등장할 때 적합<br>
- 참고로 python에서 sorted는 반환값 있고, sort는 없음 list.sort()하면 바로 정렬 -> 둘 모두 key라는 매개변수를 입력으로 받을 수 있음
- [x] 이것이 취업을 위한 코딩테스트다 with python `이진탐색` (186~205p)
- [x] **이진 탐색** 주의사항<br>
사전에 정렬되어 있어야만 함. 소스코드 그대로 외울 것!! (재귀, 반복문 모두)
조건에 엄청 큰 수가 있다 -> 이진탐색 고려<br>

##### 느낀 점
- DFS/BFS가 약한 듯함. 2차원 공간에서 이동하는 구현 문제의 경우 dx, dy를 만들어 nx, ny를 사용 
- 익숙하지 않은 python 문법 : `lambda`

### 23.01.01.일
- [x] 이것이 취업을 위한 코딩테스트다 with python `DP` (208~228p)<br>
DP : 피보나치 느낌 나는 1,2,3,5 이런거나 징검다리 느낌의 문제인데 입력 조건의 최대가 적으면 dp의심<br>
예) 적은 단위(2,3,5)들을 최소한으로 사용해서 뭐 달성하기
- [x] **Softeer 8단변속기**
- [x] **Softeer 장애물 인식** : dfs예제에서 좀 더 응용하는 건데 생각을 빨리 못해서 시간이 너무 오래걸림.
- [x] **Softeer 지도 자동 구축** : dp 문제인 건 알았는데 점화식 잘못세우고 수학을 까먹어서 한참 헤맴..<br>
*-> 23.5.1 기준 최근 BOJ에 같은 문제가 나와 다시 풀었는데 DP 없이 단순 수학계산으로도 충분히 해결 가능함*<br>
- [x] **Softeer 바이러스** : `Runtime Error` 뜰 거 같았는데 역시 뜸 -> 해결함

### 1.3.화
- [x] 이것이 취업을 위한 코딩테스트다 with python `최단경로` (230~264)
- **Dijkstra**, **heap**, **우선순위 큐**
- [x] 이것이 취업을 위한 코딩테스트다 with python `그래프 이론` (266~305p)
- **union-find**, **위상정렬**, **Kruskal**

### 1.4.수
- [x] **Softeer 금고털이** : 그리디로 풀었다가 틀려서 DP로 재접근 했는데 계속 틀림
- [x] **Softeer GBC** : 금고털이랑 비슷한 문제.. 어떻게 접근해야할지 모르겠다

##### 느낀 점
- Softeer Level 2문제는 구현, 그리디, DP쉬운 거, dfs -> 요정도 수준인 듯

### 1.5.목
- [x] 주요 알고리즘 암기
- 이진탐색 재귀
- 이진탐색 반복
- bfs/dfs
- Dijkstra
- 퀵 정렬
- union-find
- 위상정렬
- kruskal

### 1.6.금
- [x] 코테 대비 C언어 복기

### 1.7.토 (코딩 테스트 봄)
- [x] 코딩 테스트 (최소 한 문제 C/C++)
- 1번 주사위 3개 -> BOJ 2480번과 동일
- 2번 기억 안 나는데 1번과 비슷한 수준
- 3번 토너먼트 올라갈 때 각 인원이 몇 번 출전했는지
- 4번 추천... 관련이었는데 기억 안 남
- 5번 약 투여하는데 효과 발현 기간, 약 효과 있고 효과는 누적될 때 x일에 약효 최대로 하기

### 1.8.일 (알고리즘 스터디 시작)
첫 주 분량 : BOJ 1~10단계 총 `84`문제

### 1.9.월
- [x] `for`문 쓸 때 `enumarate` 써보기
- [x] `itertools`의 메소드 익숙해지기
- [x] 잘 모르고 푼 문제 복기
- [x] **#10951 A+B - 4**: `while`문 안에서 `try`와 `except` 쓰는 예외처리<br>
`input=sys.stdin.readline` 했으면 그 뒤로는 `map(int, input().split())` 그대로 쓰면 됨<br>

- [x] 파이썬 내장함수들 통달하기!!

|함수|설명|
|------|------|
|`any()`|배열 안에 하나라도 참이면 True|
|`pow()`|거듭제곱|
|`reversed(array)`|for문 거꾸로 돌리고 싶을 때 유용. `for i in reversed(array)`|
|`zip()`|묶어서 튜플 생성|
|`divmod(a,b)`|a//b와 a%b를 튜플로 묶어 반환해줌|
|`enumerate()`|for문에서 인덱스랑 값 둘다 쓸 때 유용|
|`array.count(1)`|array안의 1의 개수 반환해줌|
|`array.clear()`|리스트 모두 비움 특정값만 비우고 싶으면 `del array[i:j]` -> 그럼 전체 길이도 줄어듦|
|`append`|뒤에 삽입하고 특정 위치에 넣고 싶을 경우 `array.insert(i,x)`|
|`array.sort(reverse=True)`|값을 기준으로 정렬 `array.reverse()`는 그냥 인덱스 기준으로 뒤집음|
|`array.remove(x)`|x와 같은 값 젤 첫번째 꺼 지움|
|`all()`|배열 안에 하나라도 0이면 False 모두 참 값이면 True 반환 (3.10부터 있음)|

##### 느낀 점
- 파이썬 특징 중에 내가 약한 거 : 리스트 컴프리헨션, `zip` 함수 사용, `lambda`
-> python에만 있는 문법들은 해당 언어의 특징이니까 잘 활용하도록 해보자.
- 코테에서 내가 부족한 거 : 구현으로 푸는 경향이 있음. 자료구조를 잘 사용 안 함(스택, 큐, 힙큐 이런 거)

### 1.10.화
- `array.index(x, i, j)` : (인덱스 i 또는 그 이후에, 인덱스 j 전에 등장하는) array 의 첫 번째 x 의 인덱스<br>
- 정수 뒤에 0붙여서 실수형으로 출력하고 싶을 때 : `‘{:.3f}’.format()` 이런 식

### 1.11.수
- [x] BOJ `함수` 맨 마지막 문제부터 시작

### 1.12.목
- [x] **#1316** : 어제 못 푼 거
- [x] **#2292 벌집**

### 1.13.금
- [x] 백준 1~10단계 계속 품

### 1.14 토
- [x] 백준 1~10단계 계속 품
##### 느낀 점
- `dict`랑 `set`은 안 쓰는데 써야될 거 같음

### 1.15 일
**백준 `정렬` 마지막 문제부터 시작**
- [x] **#2738 행렬 덧셈**
- [x] **2566 최댓값**

##### 느낀 점
- `zip` 잘 쓰기. (예컨대 리스트 요소끼리 덧셈같은 거)
- `numpy`에 익숙해져 있는데 boj는 외부 라이브러리 허용 안 하므로 없이 2차원 리스트 슬라이싱 해야함.
- 딕셔너리 이해 부족임. 공부 더 할 것. 딕셔너리 써야한다는 건 알았으나 잘 못해서 머뭇머뭇 하다가 시간 많이 버림..

### 1.16.월
- [x] **#2563 색종이** : 2차원 리스트 선언을 잘못해서 오류가 났었음.
**2차원 리스트 초기화할 땐 반드시 리스트 컴프리헨션을 써야 한다!!** <br>
- [x] **#2839** : 4, 7이 예외 숫자.
- [x] **#1193** : 틀림
- [x] **#2869 달팽이는 올라가고 싶다** : 틀림
- [x] **#10757 큰 수 A+B**

### 1.17.화
- [x] **#4948 베르트랑 공준**
- [x] **#2869 달팽이는 올라가고 싶다** : 틀림
- [x] 기본수학1 5문제 남기고 **79문제 다 품**!

### 1.18.수
- [x] **#2252** : 카테고리 안 봤으면 이게 위상정렬인줄 몰랐을 거 같기도.. 
- [x] **#1193** : 홀짝 나눠서 번째가 다른데 처리를 안 했음
- [x] **#2869 달팽이는 올라가고 싶다** : 굳이 0부터 하나씩 더해갈 필요 없이 v-a까지 구해놓고 거기서 1더할지 2더할지만 구분하면 됨. 반복문 쓸 필요가 없었음. AC!
- [x] **#1193 분수찾기**

### 1.20.금
- [x] **#10250**
- [x] **#2775**
- [x] **#2839** : 설탕봉지 문제 `DP` or `Greedy`

### 1.22.일
- [x] C언어 복기 시작. Python으로 푼 앞단계 C로 풀어봄

### 1.24.화
- [x] `알고리즘 스터디` 1주차 모임

### 1.26.목
**백준 `그리디` 단계 시작**
- [x] **#11047 동전 0**
- [x] **#1931 회의실 배정** : 아이디어조차 못 떠올리겠어서 구글링 함. `lambda`를 이용해 요소 하나씩 정렬하는 법 얻음.
- [x] **#11399 ATM**
- [x] **#1541 잃어버린 괄호** : '-'를 기준으로 구분하면 된다는 걸 생각 못함.. 구글링해서 보고 함
- [x] **#13305 주유소** : 첫 시도 17점

### 1.27.금
**백준 `누적 합` 단계 시작**
- [x] **#11659 구간 합 구하기 4**
- [x] **#2559 수열** : 시간초과 뜸.
-> 슬라이싱은 배열의 원소를 복사해 오는 거기 때문에 슬라이싱 된 원소의 개수에 비례해서 시간이 걸린다.
-> 어렵게 생각할 게 아니었음. 그냥 누적합 배열에서 원하는 부분-(그거-k)번째 빼면 되는 거였음
- [x] **#16139 인간-컴퓨터 상호작용** : 50점 받음
- [x] **#10986 나머지 합** : 일단 틀림

### 1.28.토
- [x] **#10986** 시간초과 해결.
-> 모듈러 연산의 특징을 사용해야 함!
`(A + B) % C`와 `(A%C + B%C) % C`의 결과는 동일
- [x] **#11660 구간 합 구하기 5**

##### 느낀 점
python에서 2차원 배열을 이용할 때, 2차원 배열 먼저 선언하고 입력받으면 선언한만큼 빈 후 입력이 들어감.
그냥 1차원 빈 배열 선언한 후 1차원 배열을 append하면 알아서 2차원 됨

### 1.29.일
- [x] `알고리즘 스터디` 2주차 모임 (범위는 백준 `그리디` 5문제)
`time = sorted(time, key = lambda x : (x[1], x[0]))`
- [x] **#13305 주유소** 다시 풀기 -> 스터디 후 어디가 잘못됐는지 알 거 같아서 고치고 100점 받음!

### 1.30.월
- [x] **#11660 구간 합 구하기 5** AC!
- [x] **#25682 체스판 다시 칠하기 2**

#### 잊지말자!!!!
2차원 배열의 누적합 배열을 구하는 방법<br>
1) a(i, j)에서 행방향으로 누적합을 구한다.<br>
2) 행 누적합에 대해서 열방향으로 누적합을 구한다.<br>

2차원 배열 누적합을 만들자는 것까진 생각했는데, 그걸 2차원으로 안두고 flatten시키려고 생각했었음. (인공지능 공부의 폐해..)<br>
누적 합 2차원 배열은 그냥 종료 인덱스 - 시작 인덱스하면 안됨. 기하학적으로 생각해야 함. 두번 삭제된 건 한 번 더하는 그거.

### 1.31.화
**백준 `스택` 시작**
- [x] **#10828 스택**
- [x] **#10773 제로**
- [x] **#9012 괄호**
- [x] **#4949 균형잡힌 세상**
- [x] **#1874 스택 수열**
