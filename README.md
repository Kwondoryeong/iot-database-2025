# iot-database-2025
IoT 개발자 데이터베이스 저장소

## 1일차
- 데이터베이스 시스템
    - 통합된 데이터를 저장해서 운영하면서, 동시에 여러사람이 사용할 수 있도록 하는 시스템
    - 실시간 접근, 계속 변경, 동시 공유 가능, 내용으로 참조(물리적으로 떨어져 있어도 가능)

    - DMBS - SQL Server, Oracle, MySQL, MariaDB, MongoDB ...

- 데이터베이스 언어
    - SQL - Structured Query Language. 구조화된 질의 언어(프로그래밍 언어와 동일)
        - DDL(정의) : DB나 테이블 생성, 수정, 삭제(CREATE, ALTER, DROP, TRUNCATE)
        - DML(조작) : 데이터 검색, 삽입, 수정, 삭제(SELECT, INSERT, UPDATE, DELETE)
        - DCL(제어) : 권한 부여, 권한 해제 제어 언어(GRANT, REVOKE, COMMIT, ROLLBACK)

- MySQL 설치
    - Docker 오류 시(WSL update failed)
        - PowerShell -> ```wsl --update``` (windows subsystem for linux)
    1. 파워쉘 오픈, 도커 확인
        ```shell
        > docker -v
        ```
    2. MySQL Docker 이미지 다운로드
        ```shell
        > docker pull mysql
        Using default tag: latest
        latest: Pulling from library/mysql
        23d22e42ea50: Download complete
        d255dceb9ed5: Download complete
        893b018337e2: Download complete
        277ab5f6ddde: Download complete
        f56a22f949f9: Download complete
        df1ba1ac457a: Download complete
        431b106548a3: Download complete
        cc9646b08259: Download complete
        2be0d473cadf: Download complete
        43759093d4f6: Download complete
        Digest: sha256:146682692a3aa409eae7b7dc6a30f637c6cb49b6ca901c2cd160becc81127d3b
        Status: Downloaded newer image for mysql:latest
        docker.io/library/mysql:latest
        ```
    3. MySQL Image 확인
        ```shell
        > docker images
        REPOSITORY   TAG       IMAGE ID       CREATED       SIZE
        mysql        latest    146682692a3a   4 weeks ago   1.09GB
        ```
    4. Docker 컨테이너 생성 (컨테이너 : 이미지를 동작할 수 있게 만드는 것)
        - mysql-container : 이름 지정, -p : 포트 번호
        - MySQL 기본 Port번호 3306
        - Oracle Port 번호 1521
        - SQL Server 1433
        ```shell
        > docker run --name mysql-container -e MYSQL_ROOT_PASSWORD=12345 -d -p 3306:3306 mysql:latest
        
        ```
    5. 컨테이너 확인(조회)
        ```shell
        > docker ps -a
        CONTAINER ID   IMAGE          COMMAND                   CREATED              STATUS              PORTS             NAMES
        7cc97c885714   mysql:latest   "docker-entrypoint.s…"   About a minute ago   Up About a minute   0.0.0.0:3306->3306/tcp, 33060/tcp   mysql-container
        ```
    6. Docker 컨테이너 시작, 중지, 재시작
        ```shell
        > docker stop mysql-container    # 중지
        > docker start mysql-container   # 시작
        > docker restart mysql-container # 재시작
        ```
    7. MySQL Docker 컨테이너 접속
        ```shell
        > docker exec -it mysql-container bash # bash 리눅스 쉘
        ```
    8. MySQL 연결 및 종료
        ```shell
        > bash-5.1# mysql -u root -p
        Enter password:

        mysql> show database;
        ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'database' at line 1
        mysql> show databases;
        +--------------------+
        | Database           |
        +--------------------+
        | information_schema |
        | mysql              |
        | performance_schema |
        | sys                |
        +--------------------+
        4 rows in set (0.01 sec)

        mysql> exit
        Bye
        bash-5.1# exit
        exit
        ```

<img src='./image/db001.png' width='700'>

- Workbench 설치
    - 명령어를 최소화하고 UI 사용
    - https://dev.mysql.com/downloads/workbench/ MySQL Workbench 8.0.41 다운로드 설치
    - MySQL Installer에서 Workbench
    
    - Workbench 실행 후
        1. MySQL Connections + 클릭
        hostname = localhost
        store in vault - P/W 입력
        2. Navigator SCHEMAS -> Create SCHEMAS -> Name : DB_NAME, Charset : utf8, Colation : utf8_bin --> Apply
        3. DB 우클릭 - Set as Default Schema

- 관계 데이터 모델
    - 3단계 DB 구조 : 외부 스키마(실세계와 매핑) -> 개념 스키마(DB논리적 설계) -> 내부 스키마(물리적 설계) -> DB
    - 모델에 쓰이는 용어
        - 릴레이션 - 테이블과 매핑
        - 속성 - 테이블 colum
        - 튜플 - 테이블 row
        - 관계 - 릴레이션 간의 부모, 자식 연관

    - `무결성 제약조건`
        - 키 - **기본키**, **외래키**, 슈퍼키, 후보키, 대리키, 대체키
        - 개체 무결성 제약조건, 참조 무결성 제약조건, 도메인 무결성 제약조건
- SQL 기초
    - SQL 개요

    ```sql
    SELECT bookid, publisher, price
      FROM Book
     WHERE bookname LIKE '축구%'; -- 주석입니다
    ```

## 2일차
- SQL 기초
    - 개요
        - 데이터베이스에 있는 데이터를 추출 및 처리작업을 위해서 사용되는 프로그래밍 언어
        - 일반 프로그래밍 언어와 차이점
            - DB에서만 문제해결 가능
            - 입출력을 모두 DB에서 테이블로 처리
            - 컴파일 및 실행은 DBMS가 수행
            
        - DML(데이터 조작어) - 검색, 삽입, 수정, 삭제
            - SELECT, INSERT, UPDATE, DELETE
        - DDL(데이터 정의어)
            - CREATE, ALTER, DROP
        - DCL(데이터 제어어) 
            - GRANT, REVOKE

    - DML 중 (SELECT)
        ```sql
        SELECT [ALL|DISTINCT] 속성명(들)
          FROM 테이블명(들)
        [WHERE 검색조건(들)]
        [GROUP BY 속성명(들)]
        [HAVING 집계함수 검색조건(들)] -> 집계함수는 WHERE절 아닌 HAVING에 사용
        [ORDER BY 속성명(들) [ASC|DESC]] 
        ```

        - 쿼리 연습(정렬까지) : [SQL](./day02/db02_query_practice.sql)
        - 쿼리 연습(집계함수부터) : [SQL](./day02/db03_select_집계함수부터.sql)

## 3일차
- Visual Studio Code에서 MySQL 연동
    - 확장 > MySQL 검색
        - Weijan Chen 개인 개발자가 만든 Database Client 설치, MySQL 확장도 준수
            - 데이터베이스 아이콘 생성
        - Database Client는 많은 DB연결이 가능
    - Database Client
        1. 툴바의 Database 아이콘 클릭
        2. Create Connection 클릭
        3. 정보 입력 > 연결 테스트

            <img src='./image/db002.png' width='600'>

        4. Workbench 처럼 사용

            <img src='./image/db003.png' width='600'>

- SQL 기초
    - 기본 데이터 형
        - 데이터베이스에는 많은 데이터형 존재(데이터의 사이즈 저장용량을 절약하기 위해서)
        - 주요 데이터형
            - SmallInt(2Byte) - 65535가지 수(음수 포함) 저장(-32768 ~ 32767)
            - **Int(4Byte)** - 42억 정수(음수포함) 저장
            - BigInt(8Byte) - Int보다 더 큰수 저장
            - Float(4Byte) - 소수점 아래 7자리 저장
            - Decimal(5~17Byte) - Float보다 더 큰 수 저장 시
            - Char(n) - n은 가변(1~255). 고정 길이 문자열
                - 주의점! Char(10)에 Hello 글자 입력하면 **'Hello     '** 공백포함되어 저장
            - Varchar(n) - n(0~65535). 가변 길이 문자열
                - 주의점! VarChar(10)에 Hello 입력 시 **'Hello'** 저장
            - LongText(최대4GB) - 가변 길이, 뉴스나 영화 스크립트 저장
            - LongBlob(최대4GB) - mp3, mp4 음악, 영화 데잍 자체 저장 시 사용
            - Date(3) - 년-월-일 까지 저장하는 타입
            - DateTime(8) - 년-월-일 시:분:초 까지 저장
            - JSON(8) - json(파이썬 딕셔너리와 유사, 키 값 쌍) 타입 데이터를 저장

    - DDL 중 CREATE : [SQL](./DAY03/db01_ddl_query.sql)
        ```sql
        CREATE DATABASE 데이터베이스 명
        [몇가지 사항];

        CREATE TABLE 테이블 명
        (
            컬럼(속성)명 제약사항들, ...
            PRIMARY KEY (컬럼(들))
            FOREIGN KEY (컬럼(들)) REFERENCES 테이블명(컬럼(들)) ON 제약사항 (DELETE, UPDATE, DEFAULT, CASCADE)
        );
        ```
        
        - 테이블 생성 후 확인
            1. 메뉴 Database > Reverse Engineer(데이터베이스를 ERD 변경) 클릭 <-> Forward Engineer(ERD -> DB)
            2. 연결은 패스
            3. Select Schemas to RE 에서 특정 DB를 체크
            4. Execute
            5. ERD 확인

            <img src='./image/db004.png' width='600'>

    - DDL 중 ALTER
        ```sql
        ALTER DATABASE 데이터베이스 명
        [몇가지 사항];

        CREATE [TABLE] 테이블명
            [ADD 속성명 데이터타입]
            [DROP COLUMN 속성명]
            [ALTER COLUMN 속성명 데이터타입]
            -- ...
        ```
    - DDL 중 DROP
        ```sql
        DROP [DATABASE|TABLE|INDEX] 개체 명
        ```
        - 테이블 삭제. 복구 안됨! 백업 필수

    - DML 중 INSERT, UPDATE, DELETE : [SQL](./DAY03/db02_dml_query.sql)
        ```sql
        -- 삽입(INSERT)
        INSERT INTO 테이블명 [(컬럼리스트)]
        VALUES (값리스트);

        -- 다른 테이블의 데이터 가져오기
        INSERT INTO 테이블명 [(컬럼리스트)]
        SELECT 컬럼리스트 FROM 테이블명
        [WHERE 조건];

        -- 수정(UPDATE)
        UPDATE 테이블명 SET
               속성=값
            [, 속성=값]
         WHERE 조건;

        -- 삭제(DELETE)
        DELETE FROM 테이블명
         WHERE 조건;
        ```
        - INSERT 데이터 삽입, 새로운 데이터 생성
        - UPDATE 데이터 수정, 기존 데이터 변경
        - DELETE 데이터 삭제
        - `UPDATE와 DELETE는 WHERE절 미사용 시 문제 발생 소지`
            - 트랜잭선 미사용 시 복구 문제 발생 **주의!!**
- SQL 고급
    - 내장함수, NULL : [SQL](./day03/db03_sql_고급.sql)
        - 수학함수, 문자열함수, 날짜함수 등

## 4일차
- SQL 고급 : [SQL](./day04/db01_advanced_sql.sql)
    - 행번호출력
        - LIMIT, OFFSET 잘써도 필요없음
        - 행번호가 필요한 경우도 있음

- SubQuery 고급 : [SQL](./day04/db02_advanced_subquery.sql)
        - WHERE절 - 단일값(비교연산), 다중행(ALL|SOME|ANY|EXISTS|IN|NOT IN|...)
        - SELECT절 - 무조건 스칼라값
        - FROM절 - 인라인 뷰. 하나의 테이블처럼 사용 - 가상 테이블
- SQL 고급
    - 뷰 : [SQL](./day04/db03_advanced_view.sql)
        - 자주 사용할 쿼리로 만들어진 가상 테이블을 계속 사용하기 위해서 만든 개체
        - 입력, 수정도 가능. 조인된 뷰는 불가능
        - 보안적, 재사용성, 독립성을 위해서 사용
    - 인덱스 : [SQL](./day04/db04_advanced_index.sql)
        - 빠른 검색을 위해서 사용하는 개체
        - 클러스터 인덱스 : 인덱스로 테이블 생성 및 기본키 지정 시 기본키에 자동으로 생성되는 인덱스(테이블당 1개)
        - 논클러스터(보조) 인덱스 : 수동으로 컬럼들에 생성할 수 있는 인덱스(여러개 가능)
        - 주의점
            - WHERE절에 자주 사용하는 컬럼에 인덱스 생성
            - 조인문에 사용하는 컬럼(PK포함) 인덱스 생성
            - 테이블당 인덱스 개수는 5개 미만 생성할 것(너무 많으면 성능저하)
            - 자주 변경되는 컬럼에는 인덱스 생성하지 말 것(성능저하)
            - NULL 값이 많은 컬럼에 인덱스 생성하지 말 것(성능저하)
- 데이터베이스 프로그래밍
    - 저장 프로시저 : [SQL](./day04/db05_stored_procedure.sql)
        - 너무 많은 쿼리로 일을 처리해야 할 때, 파이썬등 프로그램에서 구현하면 복잡
        - 저장 프로시저 하나로 프로그램 구현 시 코드가 매우 짧아짐
        - 개발 솔루션화, 구조화 해서 손쉽게 DB처리를 가능하게 하기 위해서
        - 예제 : [SQL](./day04/db06_stored_procedure.sql)
        

## 5일차
- 데이터베이스 프로그래밍 
    - 리턴문을 쓸 수 있으면 함수, 아니면 프로시저
    - 프로시저에서도 값을 반환하려면 OUT 파라미터 선언
    - 저장 프로시저 계속
        - 결과를 반환하는 프로시저 : [SQL](./day05/db01_stored_procedure3.sql)
        - 커서사용 프로시저 : [SQL](./day05/db02_stored_procedure4.sql)
    - 트리거 : [SQL](./day05/db03_trigger.sql)
    - 사용자 정의함수 : [SQL](./day05/db04_user_defined_function.sql)
        - 리턴 키워드 사용

- 데이터베이스 연동 프로그래밍
    - PyMySQL 모듈 사용
    - 파이썬 DB연동 콘솔 : [노트북](./day05/DB05_파이썬_DB연동.ipynb)
    - 파이썬 DB연동 웹(Flask) : [Python](./day05/index.py)
        - templates 폴더내 html 지정

- 데이터 모델링
    - 현실 세계에 데이터 처리 내용을 디지털 환경에 일치시켜서 모델링
    - DB 생명주기
        1. 요구사항 수집 및 분석
        2. 설계
        3. 구현
        4. 운영
        5. 감시 및 개선
    - 모델링 순서
        1. 개념적 모델링 - 요구사항 수집분석 내용 토대로 러프하게 전체 뼈대를 세우는 과정
        2. 논리적 모델링 - ER다이어그램 체계화. DBMS에 맞게 매핑. 키 선정(추가), 정규화, 데이터 표준화
        3. 물리적 모델링 - DBMS 종류에 맞게 데이터 타입 지정, 물리적 구조 정의. 응답시간 최소화/트랜잭션 검토/저장공간 배치
    - 현재 ER다이어그램은 IE(Information Engeenering) 방식으로 설계
    - ERWin 설계 실습 : [ERWin](./day05/madangstore.erwin)

## 6일차
- 데이터 모델링 계속 : [SQL](./day06/마당대학교.sql)
    - 마당대학 데이터베이스 with Workbench : db01_madang_university.mwb(MySQL Workbench Model)
    - Forward Engineering 으로 DB 생성 확인
- 정규화 : [SQL](./day06/db03_정규화_이상현상.sql)
    - 이상현상 : 삽입이상, 삭제이상, 수정이상
        - 정규화를 제대로 못한 DB면 발생 가능
    - 함수 종속성 - 하나의 속성(A)이 다른 속성(B)을 결정지으면 A는 B의 결정자. A → B
        - 완전함수종속 - 종속성에 일치하지 않는 속성들이 하나도 없는 경우
        - 이행적종속 - A → B, B → C 성립할 때, A → C 가 성립하는 종속성
        - BCNF 해당하지 않는 경우 - A → C, B → C일 경우 C -> B 경우가 발생
    - 정규화 - 이상현상이 발생하지 않도록 릴레이션(개체, 테이블)을 분해하는 과정
        - 제1정규화 - 속성이 원자값을 가지도록 만드는 정규화(한 컬럼에 여러값이 들어갈 수 없음)
        - 제2정규화 - 모든 릴레이션의 속성이 완전함수종속인 정규화
        - 제3정규화 - 이행적 종속이 발생하지 않도록 정규화
        - BCNF정규화 - 함수종속성 A → B 가 성립시 모든 결정자 A가 후보키를 만족하는 정규화 
        - 제4정규화 - 실무 사용 적음. 다치종속성 릴레이션 가진 정규화
        - 제5정규화 - 실무 사용 적음. 프로젝트-조인 정규형. 조인종속성을 가진 릴레이션
- 트랜잭션 : [SQL](./day06/db05_transaction2.sql)
    - 데이터를 다루는 논리적인 작업단위
    - START TRANSACTION, SAVEPOINT, ROLLBACK [TO SAVEPOINT], COMMIT 트랜잭션 처리
    - 특징
        - A(tomicity) 원자성 : 트랜잭션이 원자처럼 더 이상 쪼개지지 않는 하나의 프로그램 단위로 동작해야함(All or Nothing)
        - C(onsistency) 일관성 
        - I(solation) 고립성 
        - D(urability) 지속성 
    - 동시성 제어 - 락 : [SQL1](./day06/db09_concurrency_control.sql) / [SQL2](./day06/db10_concurrency_control2.sql)
## 7일차
- 데이터베이스 관리와 보안
- 실무실습
- Python GUI로 DB연동 앱 개발

## 8일차

## 9일차