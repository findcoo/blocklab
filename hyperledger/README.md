# Hyperledger

하이퍼레져에 대해 알아보자.

- [Hyperledger](#hyperledger)
    - [Introduction 🔗](#introduction-%F0%9F%94%97)
    - [Capabilities 🔗](#capabilities-%F0%9F%94%97)
        - [Identity management](#identity-management)
        - [Efficient processing](#efficient-processing)
        - [Chaincode functionality](#chaincode-functionality)
        - [Modular design](#modular-design)
    - [Key concepts](#key-concepts)
        - [Assets](#assets)
        - [Chaincode](#chaincode)
        - [Ledger Features](#ledger-features)
        - [Privacy through Channels](#privacy-through-channels)
        - [Security & Membership Services](#security-membership-services)
        - [Consensus](#consensus)
    - [Glossary 🔗](#glossary-%F0%9F%94%97)

## Introduction [🔗](https://hyperledger-fabric.readthedocs.io/en/release-1.0/blockchain.html#introduction)

하이퍼레져 페브릭은 고도의 기밀성, 탄력성, 유연성 및 가용성을 제공하는 모듈형 아키텍쳐입니다.
각각 특성을 갖는 구성요소들을 조합하여 경제 생태계에서 생기는 복잡하고 어려운 문제들을 해결하는 목적으로 설계되었습니다.

## Capabilities [🔗](https://hyperledger-fabric.readthedocs.io/en/release-1.0/capabilities.html)

### Identity management

네트워크의 참가자는 모두 고유 아이디를 갖고 인증 과정을 거치게 됩니다. 이는 네트워크에 대한 접근 권한을 설정함으로사용자들이 인가된 네트워크에서만 활동 할 수 있게 제약합니다. <b>이는 참가자들간에 서로를 식별하는 것은 가능하지만 네트워크 권한이 없다면 해당 네트워크에서의 활동을 감시하는 것을 방지하는 역할을 합니다.</b>

### Efficient processing

node 의 성질에 맞추어 네트워크 규칙을 할당합니다. 이는 네트워크에 동시성과 병렬성을 위함입니다. 트랜잭션의 요청과 수행을 별도로 처리하기에 이와 같은 구조가 필요합니다.
우선적으로 요청을 받아 들일 수 있는 노드들은 다수의 트랜잭션을 동시에 처리합니다. 또 한 트랜잭션에 필요한 노드들과 원장의 유지관리에 필요한 노드들이 분할되어 작업의 병렬성을 지원합니다.

### Chaincode functionality

체인코드 어플리케이션은 체널상에 특정 트랜잭션 타입에 의해 발생되는 로직을 인코드합니다.
자산 소유권 변화를 위한 매개변수를 정의하는데, 예를 들어 하나에 종속된 규칙과 요구사항의 소유권을 전달할 때 이에 관한 트랜잭션을 보장합니다.

### Modular design

모듈형 아키텍쳐는 네트워크 설계에 있어 함수적인 설계를 가능하게 합니다. 이는 기존 산업의 아키텍쳐를 수용할 수 있도록 합니다.

## Key concepts

### Assets

무형의 자산 혹은 유형 자산 모두를 뜻합니다. 자산은 블록체인 내에서는 키밸류 형식의 데이터로 저장됩니다. 자산의 상태 변화에 따라 채널의 원장에 트랜잭션이 기록됩니다.
자산은 binary 데이터, json 형태로 사용 할 수 있습니다.

### Chaincode

자산을 정의하는 로직을 뜻합니다. 키 밸류 정보나 상태 데이터베이스를 읽거나 조작하는 기능을 수행합니다.
체인코드 함수는 상태 데이터베이스에 실행되며 이 작업은 트랜잭션의 요구사항에 따라 발생합니다. 
실행되면 키 벨류값들의 쓰기 작업이 일어나며 이 작업들은 네트워크를 통해 동기중인 원장들에도 적용됩니다.

### Ledger Features

상태 변화에 대한 위조 방지를 위해 연속되는 구조를 갖고 있습니다. 상태 변화는 체인코드의 실행으로 부터 발생합니다.
트랜잭션은 원장의 생성, 변경, 삭제 작업을 수행합니다.

원장은 블록체인으로 구성되며 이는 불변적이고 연속적인 데이터를 블록에 기록하는 구조입니다. 상태 데이터베이스 또한 같은 구조를 갖고 있습니다.
하나의 체널에는 하나의 원장이 있고 피어 노드들은 그들의 회원 채널의 원장을 사본으로 관리합니다.

* 범위 질의, 키 기반 조회, 복합 키 기반 질의를 사용하여 원장에 질의 요청 및 변경을 수행 할 수 있습니다.
* 읽기 전용 질의는 카우치 DB를 사용한다면 고수준 질의 언어를 사용 할 수 있습니다.
* 원장 질의에 대한 기록을 질의 할 수 있습니다.
* 트랜잭션은 체인 코드에 읽혀진 키값과 쓰여진 키값의 버전으로 구성됩니다.
* 트랜잭션은 보증된 피어들의 서명을 포함하며 이는 주문 서비스에 제출됩니다.
* 트랜잭션은 블럭으로 정렬되고 주문 서비스로 부터 채널의 피어로 전달됩니다.
* 피어들은 보증 정책을 통해 트랜잭션을 검증하고 정책을 집행합니다.
* 블럭의 추가 이전에 체인코드의 실행 시간으로 부터 변경되지 않는 자산의 상태를 보증하고자 버전 검사를 시행합니다.
* 트랜잭션이 한번 검증되고 수행되면 불변성을 갖게 됩니다.
* 채널의 원장은 블럭 정의 정책, 접근 제어 리스트, 참가자 정보들을 갖고 있습니다.
* 채널은 멤버쉽 서비스 제공자를 갖고 있습니다. 이는 다른 인증 기관의 암호적 요소들을 처리하기 위함입니다.

### Privacy through Channels

채널 별로 불변성을 갖는 원장과 자산의 상태를 조작 할 수 있는 체인코드를 갖고 있습니다.
원장은 채널의 영역안에 있음으로 만약 모든 참가자가 같은 채널에 있다면 원장은 모든 참가자들이 공유 할 수 있습니다.
혹은 특정 참가자 집단만을 허용하여 이외 사용자들이 원장에 접근 할 수 없도록 할 수도 있습니다.

### Security & Membership Services

하이퍼레저 페브릭은 모든 참가자가 고유의 정체성을 갖는 트랜잭셔널한 네트워크를 지향합니다.
공개 키 기반의 구조는 암호학적인 증명서를 생성합니다. 증명서는 기관, 네트워크 요소, 사용자 혹은 클라이언트를 묶습니다.
결과적으로 채널을 기반으로한 접근 제어 구조를 갖게됩니다. 

### Consensus

분산 원장 기술에 있어 합의라 함은 하나의 알고리즘 처럼 여겨져 왔습니다. 하지만 하이퍼레저 페브릭에서는 단순히 거래의 순서를 지키는 것을 뜻하지 않습니다.
이는 순서, 검증, 약속 등 모든 트랜잭션 흐름의 기반이 됩니다. 세부적으로는 트랜잭션과 블럭의 정확성을 확보하는 모든 과정을 합의라 할 수 있습니다.

## Glossary [🔗](https://hyperledger-fabric.readthedocs.io/en/release-1.0/glossary.html#glossary)

용어에 대한 정리는 간략하게 합니다. 세세한 사항은 위에 링크를 통해 원문을 볼 수 있습니다.

* Anchor Peer - 멤버는 anchor peer를 통해 채널상의 다른 peer들을 식별합니다.
* Block - 정렬된 트랜잭션 집합은 암호학적으로 이전 블락에 연결됩니다.
* Chain - peer가 ordering service로 받은 블럭을 검증하고 peer의 파일 시스템상의 해쉬 체인에 추가합니다.
* Chaincode - 원장에서 사용되는 비즈니스 로직입니다.
* Channel - private blockchain overlay를 뜻 합니다. 데이터의 독립성과 신뢰성을 보장합니다. 
* Commitment - transaction의 추가와 쓰기 작업을 뜻합니다. 포괄적으로는 트랜잭션의 검증을 포함합니다.
* Concurrency Control Version Check - peer간의 동기화된 상태를 유지하는 방법입니다. 트랜잭션을 쓰거나 추가할 때는 원장에 데이터가 불변함을 보장해야 합니다.
* Congiguration Block - 채널과 전체 네트워크에 영향을 주는 설정 변경 사항은 이 블럭을 생성합니다. 이 블럭은 기원이 되는 블럭의 정보와 다양한 정보를 포함합니다.
* Current State - 원장에 기록된 모든 유효한 트랜잭션의 최근 값, Chaincode는 최근 상태의 데이터 값을 대상으로 실행된다.
* Dynamic Membership - 멤버, peer, ordering service node의 추가와 삭제를 전체 네트워크에 영향 없이 수행합니다. 
* Endorsement - 체인코드의 실행에 있어 이에 대한 승인을 뜻합니다.
* Endorsement policy - 체인코드를 포함하는 트랜잭션을 실행하는 peer node의 선정에 있어 최소의 endorsing peer노드들이 필요합니다.
* Genesis block - 블럭체인 네트워크의 생성에 기여하는 configuration block
* Gossip protocol - peer node의 식별과 채널의 멤버쉽 관리, 모든 peer node에 원장 데이터 보급, 모든 peer node의 원장 상태 동기화를 수행합니다.
* Membership Service Provider - 클라이언트에 인증을 부여하는 시스템의 추상적 요소를 뜻한다. 
* Ordering Service - 트랜잭션을 유발하는 노드들의 집합 
* Policy - 보증, 검증, chaincode 관리, 네트워크 및 채널 관리에 대한 정책들이 있다.
* Proposal - 보증을 위한 요청
* State Database - 현재 상태에 관한 데이터는 상태 데이터베이스에 저장된다. 이는 chaincode에서 현재 상태를 읽기 위함이다. levelDB와 couchDB를 지원한다.