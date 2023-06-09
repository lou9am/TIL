### 3.1.수
최단 경로 시작
- [x] __#1753 최단경로__
- [x] __#1504 특정한 최단경로__ : `Dijkstra`로 풀었다가 Fail.

### 3.2.목.
- [x] __#1504 특정한 최단경로__ : 플로이드 워셜로 solve 했으나 시간초과
-> `distance` 배열을 local 처리한 후, start와 end를 인자로 하는 `dijkstra`로 다시 짜서 AC
- [x] __#13549 숨바꼭질 3__ : `DP`라고 생각했는데 `BFS` 응용 또는 `다익스트라`로 가능
- [x] __#9370 미확인 도착지__ : 틀림.
- [x] __#11404 플로이드__ : TC 만족 못함

#### 배운 점
- `다익스트라`를 start만 받는게 아니라 start, end 둘다 받는 함수로 사용하기 (플로이드 워셜 없이 직관적으로 구현 가능)
- python은 `print` 안에 `if, else` 넣을 수 있음.<br>

### 3.3.금
- [x] __#11404 플로이드__ : 어제 틀린 이유 발견. 간선이 같을 때 비용이 초기화 되고 있었음. 고쳐서 AC
- [x] __#11657 타임머신__ : `벨만 포드`. 두 번째 TC (무한히 - 가능할 때)에서 while문 탈출 못하고 있음.

#### 느낀 점
- 문제 풀기 전, 주어진 TC는 손코딩 해보는 게 좋은 버릇인듯

### 3.6.월
__빅분기 필기 공부 시작!__
- [x] __#11657 타임머신__
- [x] __#1956 운동__ : 최소 사이클의 길이 출력하기. 방향 그래프이므로 DFS로 사이클 판별해야 함. 다익스트라로도 가능한 것 같음.
- [x] __#9370 미확인 도착지__ : 경로 역추적해서 g-h나 h-g구간 연속해서 들어있나 확인했는데 틀림
- [x] 빅데이터 분석기사 필기 (20~33p)

#### 배운 점
- `벨만-포드`는 시간 복잡도가 `다익스트라`보다 안 좋으므로 음수 간선이 있을 때만 사용할 것 (음수 사이클 있을 때 -1 출력하면 벨만 포드)

### 3.7.화
__BOJ 유니온 파인드 & 트리 시작__
- [x] __#1717 집합의 표현__ : 런타임 에러(Recursion Error). 재귀 리미트 풀고 메모리 초과. 10만으로 제한 두니 시간초과. (리스트를 딕셔너리로 바꿔서 해결한 사람 존재)
- [x] __#11725 트리의 부모 찾기__ : 푸는 중

#### 배운 점
- 재귀 깊이가 깊을수록 메모리 초과가 난다. 10만 이하가 좋다고 함.

### 3.8.수
- [x] 빅분기 필기 공부 (33~49p)
- [x] __#11725 트리의 부모 찾기__ : 집합으로 바꿨는데 Fail. 이진 완전 트리라고 생각했는데 아닌 예가 존재. (n-1번만큼만 돌기 때문에 숫자가 나중에 나오면 그 부분이 비는 것)

- [x] __#1167 트리의 지름__ : 그래프에 간선 정보 저장한 후, `플로이드 워셜` 써서 가장 큰 값 찾게 했더니 메모리 초과. (v = 10만이니까 graph는 10^10임.) -> `DFS`가 정석이라고 함.

### 3.9.목
- [x] ___#1991 트리 순회__ : 그래프를 알파벳으로 변환하는 부분을 C처럼 생각해서 시간이 오래 걸렸음. python은 그냥 바로 넣을 수 있음.
-[x] __#4803 트리__ : 사이클에 담겨있는 노드만 뽑는 부분에서 헤맴

#### 느낀 점
- 트리 순회는 다 클래스 구현해서 solve.

### 3.10.금
- [x] 빅분기 필기 1과목 3장 (50~63p)
-[x] __#4803 트리__ : 반례 찾음.<br>
6 61 22 34 55 64 63 4 (노 트리인데 하나 카운팅 됨)
-> 입력의 마지막이 양 트리를 연결해버릴 경우 연결이 안 되고 있었음.
-> 맨 마지막에 부모노드 갱신 한 번 더 해서 해결. AC
- [x] __#1167 트리의 지름__ : 리트라이

#### 느낀 점
- 저번 달까진 잘 못했던 `Set` 자료형에 익숙해졌다.

### 3.11.토
- [x] 빅분기 필기 1과목 기출문제 + 2과목 1장 (64~103p)

### 3.12.일
- [x] 빅분기 필기 2과목 2장 (104~111p)
- [x] dbn 유형별 기출 이진탐색 2문제 (27, 28번)
- [x] __#5639 트리의 순회__ : `try-except`문 써야 함.<br>
-> 입력 받은 전위순회된 값을 오름차순 정렬한 다음에, 이진 탐색 트리(BST)로 만들고, 그 다음에 재귀적으로 후위순회하면 시간초과 나려나??

#### 느낀 점
- 지난 달에 `try-except`문 사용했는데 그 뒤로 안 썼더니 떠올리지 못 함.

### 3.13.월
- [x] __#1167 트리의 지름__
- [x] __#1967 트리의 지름__ : 재귀 깊이 때문에 10^6으로 제한했는데 메모리 초과 -> python3로 제출해서 해결

- [x] __#5639 이진 검색 트리__ : 오름차순 정렬 한 다음에 후위 탐색하면 안 됨. 다를 수 있음
- [x] __#2263 트리의 순회__

#### 배운 점
- 그냥 방문 처리만 하는 DFS 말고 비용까지 고려하는 DFS 함수도 사용할 줄 알아야 함.
- `Python3`와 `Pypy`의 차이점<br>
Python3는 CPython. 즉, `인터프리터`이면서 `컴파일러 언어`다. 반면에 Pypy는 `Just-in-time` 컴파일 방식을 도입, 속도 측에서 Python3에 비해 우수하다. Python3는 메모리 측면에서 pypy보다 우수하다.

### 3.14.화.
- [x] 빅분기 필기 2과목 3장 (112~125p)
- [x] __#2263 트리의 순회__ : 분할 정복으로 푼다고 함.

#### 느낀 점
- `분할정복법`에 대해 더 공부하자.

### 3.15.수
__BOJ 유니온 파인드 재시작__
- [x] __#1717 집합의 표현__ : 시간초과 해결 못함

### 3.16.목
- [x] __#1717 집합의 표현__ : `find_parent` 함수를 다르게 짜면 된다는데 여전히 안 됨.
- [x] __#1976 여행 가자__ : 첫 트라이 Fail. 지난 주 문제처럼 맨 마지막에 노드 재확인(갱신) 과정을 넣어주니 AC.
- [x] __#4195 친구 네트워크__ : 사람 이름마다 키 값을 부여해야 하나?

### 3.17.금
- [x] __#4195 친구 네트워크__ : 부모노드 업뎃 안 됨 + 시간초과.

#### 느낀 점
- 로직의 오류를 찾는 것 보다, 시간초과를 해결하는 것이 더 오래 걸림.

### 3.18.토
- [x] __#4195 친구 네트워크__ : 원인 찾아서 해결함. find_parent 함수를 잘못 사용하고 있었음. 
- [x] __#20040 사이클 게임__ : 사이클 존재 판별 부분 find(a)랑 find(b)를 비교해야 하는데 parent(a)랑 parent(b)를 비교하고 있었음. AC

## 3.20.월
- [x] 빅분기 필기 2과목 3장 (126~129p)
- [x] BOJ 앞 단계 추가된 문제들 Solve
- [x] __#10810__ 

#### 배운 점
- 파이썬에서 list[0:2] = 2이런 식으로 값을 바꿀 수 없다. 수식의 양변에 변수 개수가 같아야 한다. (왼쪽은 3개, 오른쪽은 1개)

### 3.22.수
- [x] 빅분기 필기 2과목 예상문제 + 3과목 1장 (130~167p)

### 3.23.목
- [x] 빅분기 필기 3과목 2장 (168~176p)

### 3.26.일
__BOj 최소 신장 트리 시작__
- [x] __#9372 상근이의 여행__
- [x] __#1197 최소 스패닝 트리__
- [x] __#4386 별자리 만들기__

### 3.27.월
- [x] __#4386 별자리 만들기__ : AC
- [x] __#1774 우주신과의 교감__

#### 배운 점
- Python `Key Error: 0` -> 딕셔너리에 해당 key가 없어서.

### 3.28.화
- [x] __#1774 우주신과의 교감__ : AC
- [x] __#6497 전력난__

### 3.29.수
- [x] 빅분기 필기 3과목 끝 (177~188p)
- [x] __#17472 다리 만들기 2__ : 보자마자 `MST`라는 걸 몰랐음. DFS 이용해 섬마다 번호 부여함.
