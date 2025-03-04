-- 트리거
-- 시작전 설정 변경. 트리거 사용설정 ON
-- 다음버전 MySQL에서는 사라질 예전(Deprecated)
SET GLOBAL log_bin_trust_function_creators=ON;

-- Book_log 테이블을 생성
CREATE TABLE Book_log (
	bookid_l		INTEGER,
    bookname_l		VARCHAR(40),
    publisher_l		VARCHAR(40),
    price_l			INTEGER
);

-- 트리거 설정
-- UPDATE나 DELETE 시는 old. 라고 사용 AFTER UPDATE ON 테이블명...
-- BEFORE, INSERT, UPDATE, DELETE ...
DELIMITER //
CREATE TRIGGER AfterInsertBook
	AFTER INSERT ON Book FOR EACH ROW /* 트리거가 Book 테이블에 데이터가 새로 추가되면 바로 발동 */
BEGIN
	DECLARE average INTEGER;
    INSERT INTO Book_log
    VALUES(new.bookid, new.bookname, new.publisher, new.price);
END;
//

-- Book테이블에 INSERT 실행

/* 삽입한 내용을 기록하는 트리거 확인 */ -- 트리거는 Book테이블에 새로운 데이터가 들어오면 자동 실행
INSERT INTO Book VALUES(40, '안드로이드는 전기양의 꿈을 꾸는가', '이상미디어', 25000); -- Book_log에 넣는건 트리거 밖에 없음
SELECT * FROM Book WHERE bookid=40;
SELECT * FROM Book_log WHERE bookid_l='40'; -- 결과 확인