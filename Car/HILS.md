## HILS란?
`Hardware In the Loop Simulation`의 약자로 실시간 시스템의 개발 및 시험에 사용되는 기술이다. SILS와 달리 실제 ECU(Electronic Control Unit)를 사용해 모델을 평가한다는 특징이 있다.

### HILS가 왜 필요한가?
자동차처럼 여러 모듈들이 하나의 시스템을 형성하는 경우 전체 시스템이 완성되기 전에, 즉 실차 시험 전에 각각의 모듈에 대한 모의 성능시험을 진행할 수 있다. 이로 인해 1) 개발 기간을 단축할 수 있고, 2) 실차 시험 대비 비용을 절감할 수 있으며, 3) 여러 단계의 시험 과정을 거치므로 품질 향상도 기대할 수 있다.

### HILS의 구성요소
`제어 시스템`, `플랜트`, `시뮬레이터`로 구성된다.
- 제어 시스템은 자동차 내의 제어기를 말한다.
- 플랜트(Plant)는 제어기와 연결되어 있는 물리적인 부분으로 센서, 액츄에이터 등으로 구성됩니다.
- 시뮬레이터는 가상으로 환경을 구축하여 실제 자동차 환경을 모사할 수 있는 장치이다.

### 관련 기술
__1. MILS(Model In Loop System)__  
__2. SILS(Software In Loop System)__ : ECU 시제품을 제작하기 전 단계에서 소프트웨어를 평가하는 수법. HILS와 달리 실제 ECU를 사용하지 않고 ECU, 차량 모두가 가상이다.  
__3. PILS(Processor In the Loop System)__

보통 사양 설계에서 검증과정까지 `MILS -> SILS -> PILS -> HILS -> 실기 검증환경`의 순서를 거쳐간다.

### 용어 정리
* `cluster` : 차량 내에서 주행에 필요한 정보를 보여주는 장치를 가리킨다. 통상적으로 연비, 속도, 운행 거리, 내비게이션 정보 등 다양한 주행 정보가 제공된다.
* `ECU` : Electronic Control Unit. 자동차 내의 다양한 장치들을 제어하는 전자 제어 장치.
* `Fail Injection test` : 시스템이 정상적으로 동작하는 동안 일부러 결함을 발생시켜 차량의 Fail Safe 기능을 검증하는 테스트이다.


#### 참고자료
1. [슈어소프트 HILS](https://m.blog.naver.com/suresofttech/220772067577)
2. [AEM의 HILS 기사](https://www.autoelectronics.co.kr/article/articleView.asp?idx=98)
3. [한국자동차기자협회 기사](https://www.kaja.org/1458275600/?idx=7024678&bmode=view)
4. [mdstec의 실차환경 시험의 제약 극복](http://www.mdstec.co.kr/mail/TC/AutoNews/down/HIL%20Simulation_Automotive_MDS.pdf)
