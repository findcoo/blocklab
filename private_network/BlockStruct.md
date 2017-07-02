# Block structure
javscript api를 통해 구조를 파악.

### 이더리움 블럭 구조 ###
key|type|bytes size|null|decription
:-:|:-:|:-:|:-:|:-:
number|Number|8|중단 상태|block 번호
hash|String|32|중단 상태|block 해쉬값
parentHash|String|32|중단 상태|부모 block의 해쉬값
nonce|String|8|중단 상태|PoW로 생성된 해쉬값
sha3Uncles|String|32||삼촌 노드의 sha3 해쉬값
logsBloom|String|256|중단 상태|블룸필터[refer](https://ethereum.stackexchange.com/questions/3418/how-does-ethereum-make-use-of-bloom-filters)
transactionRoot|String|32||루트 트랜잭션 주소
stateRoot|String|32||block 상태 트리의 root 주소
miner|string|20||채굴자의 주소
difficulty|BigNumber|?||해당 block의 난이도 정수값
totalDifficulty|BigNumber|?||해당 block까지 도달하기 위한 난이도 합계
extraData|String|?||외부 정보
size|Number|8||block크기 정수값
gasLimit|Number|8||block이 허용하는 최대 gas수치
gasUsed|Number|8||block의 모든 트랜잭션에 소모된 gas값
timestamp|Number|8||block수집 시각 unix timestamp
transactions|Array|||트랜잭션 배열, 혹은 단일 트랜잭션 값
uncles|Array|||삼촌 block들의 해쉬값
