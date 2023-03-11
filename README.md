# 패스트레인(여신티켓) iOS 사전 과제_박중규

## 개발 환경
- IDE : Xcode 14.2
- 언어 : Swift 5.7.2

## Deployment Target
- iOS 11.0

## 라이브러리
- 라이브러리 관리
    - CocoaPods
- 사용 라이브러리
    - RxSwift, RxCocoa, RxDataSources
    - SwiftLint

## 실행 방법
- 'main' branch에서 다운로드 해야 합니다.
- ```pod install```이 필요합니다.

## 안내 사항
- 과제 안내 내용 중 테크 스택 부분에 Swift 5, Xcode version 12 라고 안내되어있습니다.  
현재 저의 개발 환경이 Swift 5.7.2, Xcode 14.2 였기 때문에, 낮은 버전인 Xcode 12를 설치하여 과제를 진행하려고 했습니다.  
그러나 제 노트북의 macOS Monterey와 Xcode 12가 호환되지 않아 진행하지 못하였습니다.  
따라서 피치 못하게 현재 노트북의 개발 환경으로 과제를 진행하게 되었습니다.
- API에서 제공되는 썸네일 이미지 중에서 다수의 존재하지 않는 이미지들이 있었고, 이에 대한 처리를 구현하였습니다. 

## 과제 설계 방향
### 서드 파티 라이브러리
- 서드 파티 라이브러리 사용을 지양했습니다.
### 코드
- 가독성
    - 가독성을 중요하게 생각하였습니다.  
    네이밍 등 컨벤션을 적용하여 일관성과 가독성을 높이고자 하였습니다.
- 구조
    - iOS 클린아키텍처와 MVVM 구조를 적용하였습니다.  
        - 크게 Presentation, Domain, Data 레이어로 나뉩니다.
        - Presentation과 Data 레이어는 Domain 레이어에 의존하는 구조입니다.  
        Presentation -> Domain <- Data  
        내부 계층은 외부 계층을 알지 못합니다.
        - Domain
            - 가장 안쪽의 계층으로, 비즈니스 로직을 가지고 있습니다.  
            어떤 레이어도 의존하지 않으므로 재사용성과 테스트 용이성이 높습니다.
            - Data 레이어의 Repository를 이용하기 위해서 Repository 인터페이스(Protocol)이 해당 레이어에 포함되고, Use Case는 이 인터페이스에 의존합니다.  
            인터페이스에 의존하므로써 Data 레이어에 의존하지 않을 수 있습니다.  
        - Presentation
            - 화면을 그리는 View, ViewController와 화면에 그려질 데이터를 관리하는 ViewModel이 있습니다.
        - Data
            - 데이터 입출력이 진행되는 곳입니다
            - Repostiory는 Domain 레이어의 Repostiory 인터페이스에 의존하고, Network 레이어를 이용해 데이터를 가지고 옵니다.
    - Network 레이어를 구성하였습니다.  
    Moya 라이브러리의 구조를 참고하여 Network 레이어를 구현하여 재사용성과 테스트 용이성을 높이려고 하였습니다.
    - 함수들이 최대한 단일한 책임을 지도록 분리하였습니다.
    

      
