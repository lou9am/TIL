## Fail Safe란?

차량에서 Fail Safe란, 차량 주행 중 차량 일부에 결함 또는 고장이 발생했을 때, 다른 안전장치가 작동하여 결정적인 사고나 파괴를 예방하는 장치를 의미한다.

### Why Fail Safe?
자율주행 시대에 Fail Safe가 왜 필요할까?

사람의 경우 운전을 할 때, 기본적으로 차량의 소리/진동 등을 통해 현재 차량의 상태에 대해 느낄 수 있다. 또한, 현재 차들은 구조적/기능적으로 결함이 발생되었을 때 운전자에게 경고를 전달할 수 있도록 설계되어 있다. 사람이 운전을 하고 있을 경우에는 이러한 방식으로 위험에 대해 어느 정도 대응이 가능하지만, 자율주행 자동차가 발전함에 따라 운전에 사람의 개입이 줄어들고 있다. 따라서, 완전 자율주행을 위해서는 자동차가 스스로 고장을 진단하고 그것을 극복해 나가는 Fail Safe 프로세스가 필요한 것이다.

### Fail Safe 3단계
Fail Safe는 아래와 같이 3단계로 구분된다.

1. __Fail Passive__
- 부품이 고장나면 운행을 통상 정지, 상업기계에서 일반적으로 사용한다.
2. __Fail Active__
- 부품이 고장 나면 기계는 경보를 울리는 가운데 짧은 시간 동안 운전이 가능
3. __Fail Operational__
- 부품에 고장이 있어서 기계는 추후의 보수가 될 때까지 기능을 유지하며 운전상 제일 선호하는 방법


### 1. Fail Passive
부품이 고장나면 `운행을 통상 정지`하는 단계이다.
자율주행 자동차에서 엔진/모터 등 주행의 안전성과 직결되는 부품에서 이상이 감지되었다면, 바로 운행을 정지해야 한다. 조향/가감속과 직접적으로 관련된 부품들 또한 이 영역에 해당한다.

Fail Passive의 경우, 사람이 운전할 경우와 자율주행 모두 즉각 멈춰야 한다.

### 2. Fail Active
부품이 고장나면 기계는 경보를 울리고, `짧은 시간 동안 운전이 가능`한 단계이다.
주행 안전성과는 관련이 있지만 1단계만큼 직결되지 않아 즉각적인 정지는 요구하지 않는 고장이 이에 해당한다.
갓길 등 정차가 가능한 안전한 지역까지 이동하는 짧은 시간동안만 주행을 한다.

### 3. Fail Operational
부품에 고장이 있어서 기계는 `추후의 보수가 될때까지 기능을 유지`하는 단계이다. 운전상 가장 선호하는 방법이다.
당연하게도, 모든 기능들이 이 단계처럼 움직이면 좋겠지만 앞서 말했듯이 고장이나 결함의 종류에 따라 다르기 때문에 주행 안전성을 고려하여 1,2,3단계에 맞춰 분류하는 것이 사용자의 안전성을 극대화하는 올바른 Fail Safe이다.

---

### Fail Safe 현 시점
NXP의 기사에 따르면, 현재 Fail Safe는 운전자가 부분적으로 개입해야하는 단계에 있다고 한다.

<center>
  <img
    src="https://www.nxp.com/assets/images/en/blogs/System-availability-1024x460.jpg"
    width="400"
    height="200"
  />
</center>

결함을 감지하고, 해당 결함을 Safe State System에 알려 복구까지 가능한 단계이다. 


### 관련 기술
이와 관련해서 예전에 인상깊게 본 현대자동차의 특허 시스템이 있다. 이름은 __자율주행 자동차의 브레이크 고장 대응 시스템__ 으로 자율주행 차량에서 고장이 발생했을 경우, 고장 신호를 보내고 근처에 있던 다른 차량이 구조 신호를 수신해 해당 차량을 구조하는 방식이다.
<center>
  <img
    src="https://www.hyundai.co.kr/image/upload/asset_library/MDA00000000000025029/b3e88a7b2b304e27a4ddaead8ef328e3.jpg"
    width="400"
    height="300"
  />
</center>
<center>
  <img
    src="https://www.hyundai.co.kr/image/upload/asset_library/MDA00000000000025030/41b848cf5a7e40e688d5c74d0c329493.jpg"
    width="400"
    height="300"
  />
</center>

개인적으로 군집주행에 관심이 있고, 작년에 프로젝트 주제로 자율주행+도킹이 가능한 차량을 구현해보면 어떨까 싶어 관련 자료를 찾다가 발견한 기술이다.

차량간의 V2V 통신과 도킹 기술을 이용해 Fail Safe를 차량 외적으로 구현하는 방식을 생각해내다니. 정말이지 대단하고 감탄이 나오는 기술이다.

도킹을 정확히 어떤 방식으로 하게 되는지는 언급이 되지 않지만, 먼 미래에는 도로 위 차량들이 벌들처럼 연결되고 통신하며 원활히 움직이는 시대가 오지않을까. 그런 기대를 해본다.

<br>

#### 참고자료
1. [자동차 산업전문포털의 Fail Safe 정의](https://www.korea-autonews.com)
2. [NXP의 Fail Safe의 진화 기사](https://www.nxp.com/company/blog/automotive-functional-safety-the-evolution-of-fail-safe-to-fail-operational-architecture:BL-AUTOMOTIVE-SAFETY-EVOLUTION)
3. [현대자동차 브레이크 고장 대응 시스템](https://www.hyundai.co.kr/story/CONT0000000000050273)
