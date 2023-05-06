## NAS 1편. NAS란 무엇인가
## 오늘의 논문 "Neural Architect Search: A Survey"
MAY 04, 2023

### 인트로
AI 모델들을 돌릴 때마다 내가 제일 싫어했던 건 데이터 라벨링도 아니요, 통계 분석도 아니요, 바로바로 `하이퍼파라미터 튜닝`이었다. 인간이 해야할 일을 컴퓨터한테 대신 맡기는 주제에 더 좋은 조건을 찾기 위해 가능한 모든 경우의 수를 대입해 튜닝한다는 게 뭐랄까, 나한테는 '목적과 의미를 잃은 일'이었다.  
1) 답이 없기 때문에 모든 경우의 수를 다 대입 해야함
2) 그게 최적의 결과를 내도 왜 그런지 모름. 그냥 이 경우에 저 조합이 넣어보니까 잘 맞더라

라는 건 마치 황순원의 소나기에서 보라색은 불행을 암시하는 장치라고 했지만 작가 본인은 "그거 그냥 내가 좋아하는 색인뎁쇼."하는 느낌이다.

그래서 아카데미에서 "요즘은 하이퍼 파라미터 튜닝을 다 대입한 뒤 최적의 값을 내뱉어주는 기능이 있다."는 걸 알았을 때 "유레카!"를 맛보았다. 오늘은 그 하이퍼 파라미터 튜닝을 대신 해주는 방법론인 NAS(Neural Architect Search)를 정리한 논문을 읽어본다.

#### 태그
#AutoML #NAS

### Abstract
NAS를 도식화 하면 아래의 3개로 범주를 나눌 수 있다.
1. Search Space
2. Search Strategy
3. Performance Estimation Strategy

### 1. Search Space
- 활성화 함수, layer 수, node 개수 등 딥러닝에서 우리가 선택할 수 있는 하이퍼 파라미터.
- 더 많은 항목을 Search Space에 추가할수록 최적의 구조를 찾을 가능성이 높아지겠지만, 당연하게도 인자가 그만큼 늘어나기 때문에 더 많은 시간과 비용이 발생한다. (늘 떠안게 되는 trade-off...)

### 2. Search Strategy
- 정의된 space안에서 어떤 것을 선택하여 architecture를 찾을지 결정.
- 강화학습을 이용하기도 하고 진화론적인 방법을 이용하기도 한다.

### 3. Performance Estimation Strategy
- NAS의 목적은 사용된 적 없는 새 데이터(unseen data)에서 높은 예측 수행력을 보이는 architecture를 찾는 것이다.
- 따라서 탐색된 구조의 성능을 측정한 후, 다음 구조를 찾는데 활용(구조도에 보이는 loop)하여 최적의 구조를 찾아간다.

### NAS의 Challenging은 무엇이냐?
위의 trade-off를 보면서 힌트를 얻었다시피, 바로 시간과 비용을 최대한 줄이는 것이다. 논문의 Table 1을 보면 NAS의 속도를 향상시키기 위한 4가지 방법이 나와있다.

|Speed-up method|How are speed-ups achieved?|
|--|--|
|Lower fidelity estimates|적은 epoch을 학습, 모델 downscale화, data downscale화|
|Learning Curve Extrapolation|몇 번의 epoch후 `Extrapolation`|
|Weight Inheritance/Network Morphisms|scratch로부터 모델을 학습시키는 대신, 부모 모델로부터 가중치를 학습시켜 `warm-started` 시킴|
|One-Shot Models/Weight Sharing|`one-shot` 모델만 학습, 가중치는 다른 구조들을 통해 공유됨.|

#### terms
1. `Extrapolation` : 한국어로 해석하면 `외삽법`이라고 하는데 별로 입에 잘 붙지는 않는다. 원래의 관찰 범위를 넘어서는 다른 변수와의 관계에 기초하여 변수의 값을 추정하는 과정을 말한다.
2. `warm-start` : 하이퍼 파라미터 튜닝에서 warm start란, 이전 튜닝 과정에서 쓴 하나 이상의 값을 이번 튜닝 과정의 시작단계에서 사용하는 것이다. (일종의 웜업!) 이전 튜닝 과정의 하이퍼 파라미터 값은 새 튜닝 과정에서 어떤 조합으로 구성하는 것이 좋은지 알려주기 때문에 더 빠른 수렴 속도를 보이고, 추천된다. (더 자세한 정보는 참고자료 4를 보기)
3. `one-shot NAS` : 모델들 사이에서 가중치(weight)를 공유하여 활용하는 것. 복잡한 search space에서 강화학습이나 hyperneworks 없이 architecture를 식별할 수 있다.

### 아웃트로
하루에 한 편을 통째로 다 리뷰하면 베스트겠지만, 아쉽게도 꼬리에 꼬리를 물고 이어지는 다양한 용어들과 그때마다 요구되는 새로운 지식들 때문에 오늘은 간단하게 전체적인 개요만 살펴본다.

오늘 살펴본 부분 중에서, 개인적으로 warm-start와 one-shot 방식이 흥미로웠다. 설명만 보면 간단한 것 같지만, 그걸 생각해내는 건 어려운 일이다. 동일한 의미는 아니지만 문득 책에서 읽은 명언이 떠오른다.

> "단순하게 설명하지 못하면, 그 내용을 충분히 이해하지 못한 것이다."  
-알버트 아인슈타인-

프로젝트를 할 때만, 그것도 늘 혼자서 하던 논문 리뷰를 글로 정리해서 올리려니 내가 맞게 이해한 게 맞나 거듭 확인하게 된다. 혹 잘못된 부분이 있다면 지적은 두 팔 벌려 환영입니다.

### 참고자료
1. [LG AI 연구원 블로그](https://m.post.naver.com/viewer/postView.naver?volumeNo=33500636&memberNo=52249799)
2. [Jinu님의 블로그](https://ahn1340.github.io/neural%20architecture%20search/2021/04/26/NAS.html)
3. [warm start와 관련된 Stack Exchange 글](https://or.stackexchange.com/questions/2576/what-exactly-is-a-warm-start)
4. [Amazon AWS의 warm start hyperparameter job](https://docs.aws.amazon.com/sagemaker/latest/dg/automatic-model-tuning-warm-start.html)
5. [One-shot NAS 문서](https://nni.readthedocs.io/en/v2.4/NAS/one_shot_nas.html)
 6. [Understanding and Simplifying One-Shot Architecture Search 논문](https://proceedings.mlr.press/v80/bender18a/bender18a.pdf)
