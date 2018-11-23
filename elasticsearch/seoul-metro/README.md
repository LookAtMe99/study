- 원본 : https://github.com/kimjmin/elastic-demo.git 을 토대로 study
- 과거의 내용(elastic version, data 등)이 수정되어(혹은 내가 잘 몰라서) 원본으로는 동작하지 않아서 조금 수정하면서 실행해본 example 입니다.

Pre-condition
```
install nodejs 8 latest version
install elk 6.4.1
npm install (csv parser)
```

## 1. 서울시 지하철 유동인원 데이터
### 1.1 ELK 설정
#### elasticsearch

- 인덱스명: seoul-metro-2016
- 타입명: seoul-metro
- 매핑 정보:

필드명 | 타입 | 설명
---- | ---- | ----
\_timestamp | datetime | 승/하차 시간. 1시간 단위.
station_num | integer | 역 번호 (421, 430 ...)
station_name | string | 역 이름 : 서울역(180)
people_in | integer | 승차인원
people_out | integer | 하차인원


- 매핑 정보 입력:

```
curl -XPUT '<host url>:9200/seoul-metro-2016' -H 'Content-Type: application/json' -d '
{
  "mappings" : {
    "seoul-metro" : {
      "properties" : {
        "time_slot" : { "type" : "date" },
        "station_num" : { "type" : "integer" },
        "station_name" : { "type" : "text" },
        "people_in" : { "type" : "integer" },
        "people_out" : { "type" : "integer" }
      }
    }
  }
}'
```

#### logstash

- logstash.conf:

```
input {
  file {
    codec => json
    path => "<log folder>/*.log"
  }
}

filter{
  mutate {
    remove_field => [ "@version", "@timestamp", "host", "path" ]
  }
}

output{
  elasticsearch{
    hosts => "<host url>:<elastic port>"
    index => "seoul-metro-2016"
    document_type => "seoul-metro"
  }
}
```

### 1.2 데이터 수집

> 서울교통공사 홈페이지의 공공데이터 게시판을 가면 지하철 이용 인원에 대한 정보를 excel file 로 다운받을 수 있음

#### 역별 시간대별 승하차 인원 현황(2016년) 
- 설명: 2016년도 역별 시간대별 승하차 인원.
- 제공: [서울교통공사](http://www.seoulmetro.co.kr/)
- 방법:
  1. http://www.seoulmetro.co.kr/kr/board.do?menuIdx=551&bbsIdx=2204453 접속.
  1. 원하는 년도 - Excel 파일 다운로드.
  1. Excel 파일 열어서 다른이름으로 저장 선택 후 csv 형식으로 저장.
  1. 저장한 csv 파일을 다시 윈도우 메모장으로 열어서 UTF-8 포맷으로 선택 후 새로 저장.
  1. 파일명을 `원하는 이름`으로 변경
  1. bin/metro.js 에서 path 정의 (현재 소스에는 ./source/2016.csv 로 정의)

### 1.3 데이터 생성
- bin/metro.js에서 data가 생성될 폴더 정의 및 생성 (현재 소스에는 ./data 로 정의되어 있음)
- data 생성
```
node bin/metro.js
```

### 1.4 추출된 데이터 sample
- ./sample

