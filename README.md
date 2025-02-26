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
        [HAVING 집계함수 검색조건(들)]
        [ORDER BY 속성명(들) [ASC|DESC]] 
        ```

        - 쿼리 연습(정렬까지) : [SQL](./day02/db02_query_practice.sql)
        - 쿼리 연습(집계함수부터) : [SQL](./day02/db03_select_집계함수부터.sql)

## 3일차
- SQL 기초
    - DDL 중 INSERT, UPDATE, DELETE