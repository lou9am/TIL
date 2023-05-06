
## NAS 2편. NAS의 3가지 구조 (1) : Search Space
## 오늘의 논문 : "Neural Architect Search : A Survey"
MAY 06, 2023

### 인트로
지난 번 1편에서 대략적으로 개요만 살핀 NAS의 3구조 중 첫 번째인 `search space`에 대해 자세히 알아보는 시간을 갖는다.  
참고로, 지난 1편에서 굳이 언급하지 않았지만 기본적으로 전반적인 머신러닝, 딥러닝의 지식은 갖고 있다는 걸 가정하에 논문 리뷰를 하기 때문에 기본적인 용어나 지식은 설명하지 않는다. (예: CNN에서 pooling이 뭔지, neural network의 구조가 어떤지, SOTA가 뭔지 등)  

[NAS 1편.NAS란 무엇인가](https://github.com/lou9am/TIL/blob/main/Paper%20Review/NAL%201편%20-%20구조와%20어려운%20점.md)


### 이번 편의 목표
1. NAS에서 Search Space가 무엇인지 확실히 알고가기
2. Search Space의 종류와 연구 동향 파악하기
3. Cell-based Search Space의 장점 3가지 기억하기

#### 태그
#AutoML #NAS  

---
<br>

### 1. Search Space
- Search space란, NAS가 어떤 `neural architecture`를 탐색할지 정의하는 것이다.
- 최근 연구의 일반적인 search space는 다음과 같다.

### 가. Chain Structured 구조
상대적으로 단순한 search space는 `chain-structured neural networks`, 즉 체인 구조의 뉴럴 네트워크다. 이러한 구조는 n개의 layer들의 시퀀스로 이루어져있다. (i-1번째 layer로 부터 입력을 받아 i번째 layer를 이루는 구조)<br>
따라서 search space는 다음과 같은 것들을 파라미터로 사용할 수 있다.
1. 최대 layer 수 (n)
2. 매 layer가 수행할 기능 (pooling인지, convolution인지 등등)
3. 각 2번 기능에 해당하는 하이퍼파라미터들 (필터 개수, 커널 사이즈, conv layer의 stride, FC-network의 unit 수 등)

3번은 2번에 영향을 받는다는 점을 주목하면, 우린 여기서 한 가지 사실을 알 수 있다.  
바로 "search space는 길이가 고정되어있지 않다는 것." (= search space는 조건에 따라 달라진다.)  
<br>

### 나. hand-crafted 구조
최근의 NAS 연구들은 위의 체인구조가 아닌 `hand-crafted architecture`라는 구조를 사용한다. 이 구조는 layer들 간의 연결을 건너 뛰며 보다 더 복잡한 `multi-branch network`를 혼합하고 있다.  

이 경우, input은 chain-structured와 달리, 이전 레이어들의 아웃풋(출력)으로 이루어진 함수의 형태가 된다. 이렇게 함수화된 결과를 사용하면 자유도가 눈에 띄게 증가하는 결과를 보인다. 이 함수를 어떻게 설정하는지 바꾼 Residual Nets, DenseNets 등의 연구가 있다.  
<br>

### 다. cell-based Search Space
`hand-crafted architecture`의 경우, 아키텍처를 셀화(또는 블록화)하여 cell search space를 구현한 연구도 있다.  
이 경우, `normal cell`과 `reduction cell`로 나뉜다. 이름에서 알 수 있듯이, normal cell은 입력의 차원을 보존한 cell이고, reduction cell은 차원을 줄인 cell이다.  
최종 아키텍처는 이러한 셀들을 쌓아서 만들게 된다. 이러한 방법은 앞선 방식에 비하면 __3가지__ 이점이 존재한다.

### cell search space의 장점 3가지
1. `search space`의 __크기가 대폭 줄어든다.__ 
- cell은 보통 전체 아키텍처에 비해 적은 layer로 이루어졌기 때문이다.
- Zoph, 2018의 연구에 따르면 2017년도 자신이 한 연구에 비해 __7배__ 빨라졌다고 한다.
2. cell화 된 아키텍처는 __변경이 쉽고 다른 데이터 셋에 적용하기도 쉽다.__
- 그저 모델에 쓰인 cell과 필터의 개수만 변경하면 되기 때문이다.
- Zoph, 2018의 연구에 따르면 CIFAR-10 데이터셋을 이용하는 ImageNet에서 이 방식을 적용한 후, SOTA를 이루었다고 한다! (2023년 기준은 다를 수 있음)
3. 블록을 반복하여 만드는 구조는 일반적으로 유용한 디자인이라고 알려져 있다.
- 예를 들면 LSTB이나 RNN이 있다.

cell-based search space를 사용하면, `macro-architecture`를 정해야 한다. 즉, 얼마나 많은 cell을 사용할지, 실제 모델에서 그 셀들을 어떻게 연결할지를 정해야 한다는 뜻이다.  

최근 연구는 search space를 macro(전체 아키텍쳐)와 micro(셀 단위)로 나누어 두 가지를 함께 쓰는 방향으로 이루어지고 있다. 
<br>  

---
### 아웃트로
앞선 1편에서 NAS의 어려움은 비용과 속도를 줄이는 것이라고 살펴본 바가 있다. 이러한 문제점을 블록화(셀화)로 해결한 점이 개인적으로 몹시 흥미롭다. <br>  
또한, ImageNet에서 SOTA를 달성했었다기에 현 2023.5월의 SOTA가 궁금해 찾아보니 __ViT-H/14__ 라는 모델의 정확도가 무려 __99.5%__ 였다. 내가 만든 건 아니지만, 빠르게 발전하는 시대의 과도기 속에서 살고 있다는 게 괜시리 감동적이었다. 10년 후, 20년 후엔 세상이 또 얼마나 멋지게 변했을지 궁금하고, 그 주축에는 못들어도 변두리에서나마 작은 기여를 하는 개발자로 성장하고 싶다.  
<br>

### 참고자료
- [김도형 연구원님의 논문 세미나 동영상](https://youtu.be/FjV6Ty3PDcs)
