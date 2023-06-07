# 2과목 SQL 활용
(유선배 SQL 개발자, SQL 자격검정 실전문제 문제집을 바탕으로 정리)  
<br>

## 그룹 함수
- `GROUP BY`하여 나타낼 수 있는 데이터를 구하는 함수.
- 집계 함수와 소계(총계)함수로 나뉜다.

### 소계 함수
1. `ROLLUP`
- 인수의 순서에 따라 결과가 달라짐

2. `CUBE`
- 조합할 수 있는 모든 그룹에 대한 소계를 집계하기 때문에 인수의 순서가 바뀌어도 결과가 바뀌지 않음

3. `GROUPING SETS`
- 특정 항목에 대한 소계를 계산
- 인자값으로 ROLLUP이나 CUBE를 사용할 수 있다.
- 인자에 ( )나 ROLLUP이 들어가 있으면 총합계 표시

4. `GROUPING`
- 원하는 위치에 원하는 텍스트를 출력할 수 있다.


## 윈도우 함수
- `OVER` 키워드와 함께 사용
- `WINDOWING` 절을 이용하여 집계하려는 데이터의 범위를 지정할 수 있다.

### WINDOWING 절
- WINDOWING절의 default는 `RANGE UNBOUNDED PRECEDING`이다.

1. UNBOUNDED PRECEDING
- 위쪽 끝 행 (첫 행)

2. UNBOUNDED FOLLOWING
- 아래쪽 끝 행 (마지막 행)

3. CURRENT ROW
- 현재 행

4. n PRECEDING
- 현재 행에서 위로 n만큼 이동

5. n FOLLOWING
- 현재 행에서 아래로 n만큼 이동


### 1. 순위 함수
1. `RANK`
- 같은 순위가 존재하면 존재하는 수만큼 다음 순위 건너뜀
- 1,2,2,2,5

2. `DENSE_RANK`
- 다음 순위를 건너뛰지 않고 이어서 매김
- 1,2,2,2,3

3. `ROW_NUMBER`
- 동일한 값이라도 각기 다른 순위 부여
- 1,2,3,4,5

### 2. 집계 함수
1. `SUM`
- 인자값으로 숫자형만 올 수 있다.
- SUM하는 컬럼을 OVER 절에서 ORDER BY 절에 명시해주면 RANGE UNBOUNDED PRECEDING 구문이 없어도 누적합이 집계된다.

2. `MAX`

3. `MIN`

4. `AVG`

5. `COUNT`

### 3. 행 순서 함수
1. `FIRST_VALUE`
- MSSQL에서는 지원하지 않는다.
- 파티션 별 가장 선두에 위치한 데이터를 구하는 함수

2. `LAST_VALUE`
- MSSQL에서는 지원하지 않는다.
- 파티션 별 가장 끝에 위치한 데이터를 구하는 함수
- default가 RANGE UNBOUNDED PRECEDING이므로 RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING으로 명시해주어야 모든 행이 마지막 행을 가리킨다.

3. `LAG`
- MSSQL에서는 지원하지 않는다.
- 파티션 별로 특정 수만큼 앞선 데이터를 구하는 함수
- 두 번째 인자값을 생략하면 default는 1이다.

4. `LEAD`
- MSSQL에서는 지원하지 않는다.
- 파티션 별로 특정 수만큼 뒤에 있는 데이터를 구하는 함수
- 두 번째 인자값을 생략하면 default는 1이다.


### 4. 비율 함수
1. `RATIO_TO_REPORT`
- MSSQL에서는 지원하지 않는다.
- 파티션 별 합계에서 차지하는 비율을 구하는 함수

2. `PERCENT_RANK`
- MSSQL에서는 지원하지 않는다.
- 해당 파티션의 맨 위 끝 행을 0, 맨 아래 끝 행을 1로 놓고 현재 행이 위치하는 백분위 순위값을 구하는 함수

3. `CUME_DIST`
- MSSQL에서는 지원하지 않는다.
- 해당 파티션에서의 누적 백분율을 구하는 함수
- 결과값은 0보다 크고 1보다 작거나 같은 값을 가진다.

4. `NTILE`
- 주어진 수만큼 행등을 n등분한 후 현재 행에 해당하는 등급을 구하는 함수
- 할당할 행이 남았을 경우 맨 앞의 그룹부터 하나씩 더 채워진다.



## Top-N 쿼리

1. `ROWNUM`
- pseudo column이다.
- SELECT 절에 ROWNUM 컬럼을 추가해 자동으로 번호를 매긴다.
- 행이 반환될 때마다 순번이 1씩 증가하기 때문에 WHERE ROWNUM = 5같은 건너뛰기 조건은 성립될 수 없다.
- ROWNUM은 **항상 < 조건이나 <= 조건으로 사용**해야 한다.
- SELECT 절에서는 논리적으로 ORDER BY 절이 WHERE 절보다 나중에 수행되기 때문에 WHERE ROWNUM을 먼저한 수 ORDER BY를 하면 랜덤하게 뽑은 후 순위를 매기는 격이 되므로 주의한다.

## 셀프 조인 (Self Join)
- FROM 절에 같은 테이블이 두 번 이상 등장하기 때문에 혼란을 막기 위해 **ALIAS를 반드시 표기**해주어야 한다.

## 계층 쿼리
1. `LEVEL`
- 현재의 DEPTH 반환. 루트 노드는 1이다.

2. `SYS_CONNECT_BY_PATH`
- 루트 노드부터 현재 노드까지의 경로를 출력

3. `START WITH`
- 경로가 시작되는 루트 노드를 생성

4. `CONNECT BY`
- 루트로부터 자식 노드를 생성해주는 절

5. `PRIOR`
- 바로 앞에 있는 부모 노드의 값을 반환

6. `CONNECT_BY_ROOT`
- 루트 노드의 주어진 컬럼 값을 반환

7. `CONNECT_BY_ISLEAF`
- 가장 하위 노드인 경우 1을 반환, 그 외에는 0을 반환

8. `ORDER SIBLINGS BY`
- 같은 레벨끼리 정렬
