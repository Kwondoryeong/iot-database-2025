-- 데이터베이스 생성
CREATE DATABASE sample;

-- 데이터베이스 생성(CharSet, Collation 지정)
CREATE DATABASE sample2
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- 데이터베이스 변경
ALTER DATABASE sample
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- 데이터베이스 삭제
-- 운영DB에서 하지 말것
DROP DATABASE sample;

-- 테이블 생성
-- 3-34 NewBook 테이블을 생성하세요. 정수형은 Integer사용, 문자형은 가변형인 Varchar를 사용하십시오.
-- 기본키를 설정합니다.
-- 기본키가 하나면 컬럼하나에 작성 가능
CREATE TABLE	NewBook (
	bookId		INTEGER PRIMARY KEY,
    bookName 	VARCHAR(255),
    publisher	VARCHAR(50),
    price		INTEGER 
);
-- 기본키 두 개 이상인 경우 PRIMARY KEY (컬럼, 컬럼, ...) 사용
CREATE TABLE	NewBook (
	bookId		INTEGER,
    bookName 	VARCHAR(255),
    publisher	VARCHAR(50),
    price		INTEGER,
    PRIMARY KEY	(bookid, publisher) -- PRIMARY KEY 여러개 일 경우
);

DROP TABLE NewBook;

-- 테이블 생성 시, 제약조건을 추가가능
-- bookname은 NULL을 가질 수 없고, publisher는 같은 값이 있으면 안됨
-- price는 값이 입력되지 않은 경우 기본 값인 10000을 저장
-- 최소 가격은 1000원 이상으로 한다.

CREATE TABLE NewBook (
	bookId		INTEGER,
    bookName 	VARCHAR(255) NOT NULL,
    publisher	VARCHAR(50) UNIQUE,
    price		INTEGER DEFAULT 10000 CHECK(Price >= 1000),
    PRIMARY KEY (bookId)
);


-- 3-35 아래 속성의 NewCustomer 테이블을 생성하시오.
-- custid - INTEGER, 기본키
-- NAME - VARCHAR(100) NOT NULL
-- address - VARCHAR(255) NOT NULL
-- phone - VARCHAR(30) NOT NULL
CREATE TABLE NewCustomer (
	custid		INTEGER PRIMARY KEY,
	name 		VARCHAR(100) NOT NULL,
	address		VARCHAR(255) NOT NULL,
	phone		VARCHAR(30)	NOT NULL
);

-- 3-36 아래 속성의 Neworders 테이블을 생성하시오.
-- orderid - INTEGER, 기본키
-- custid - INTEGER, NOT NULL, FORIEN KEY(NewBook bookid)
-- bookid - INTEGER, NOT NULL, FK(NewCustomer custid)
-- saleprice - INTEGER
-- orderdate - DATE

CREATE TABLE NewOrders (
	orderid		INTEGER,
    custid		INTEGER NOT NULL,
	bookId		INTEGER NOT NULL,
    saleprice	INTEGER,
    orderdate	DATE,
    PRIMARY KEY (orderid),
    FOREIGN KEY (custid) references NewCustomer(custid) on delete cascade,
	FOREIGN KEY (bookId) references NewBook(bookId) on delete cascade
);

-- ALTER
-- 3-37 NewBook 테이블에 VARCHAR(13)의 isbn 속성을 추가하시오.
ALTER TABLE NewBook ADD isbn VARCHAR(13);

-- 3-38 New Book 테이블에 isbn 속성의 데이터 타입을 INTEGER형으로 변경하시오.
ALTER TABLE NewBook MODIFY isbn INTEGER(13);

-- 3-39 NewBook 테이블의 publisher 제약사항을 NOT NULL로 변경하시오.
ALTER TABLE NewBook MODIFY publisher VARCHAR(100) NOT NULL;

-- DROP(조심)
-- 3-42 NewBook 테이블을 삭제하시오.
-- 3-43 NewCustomer 테이블을 삭제하시오. 만약 삭제가 거절된다면 원인 파악 후 관련 테이블 함께 삭제하시오.
-- 관계에서 부모테이블은 자식테이블을 지우기 전에 삭제할 수 없음!
-- NewCustomer 테이블을 삭제하기 위해서는 이 테이블을 참조하고 있는 NewOrders 테이블을 먼저 삭제해야함.
DROP TABLE NewBook;
DROP TABLE NewOrders;
DROP TABLE NewCustomer; 