-- 7-1 계절학기 테이블
DROP TABLE IF EXISTS Summer; -- 기존 테이블이 존재하면 삭제

CREATE TABLE Summer (
	sid		INTEGER,
    class	VARCHAR(20),
    price	INTEGER
    );

SELECT * FROM Summer;

-- 기본 데이터 추가 -> MySQL에서만 가능, 한번에 INSERT
INSERT INTO Summer VALUES (100, 'JAVA', 20000), (150, 'PYTHON', 15000), (200, 'C', 10000), (250, 'JAVA', 20000);

-- 계절학기 듣는 학생의 학번과 수강과목
SELECT sid, class
  FROM Summer;

-- c강좌 수강료
SELECT price
  FROM Summer
 WHERE class LIKE 'C';
 
-- 수강료가 가장 비싼 과목
SELECT DISTINCT class
  FROM Summer
 WHERE price = (SELECT MAX(price)
				  FROM Summer);

-- 계절학기를 듣는 학생수와 수강료 총액
SELECT COUNT(*) AS '학생수'
	 , SUM(price) AS '수강료 총액'
  FROM Summer;

/* 이상현상(abnormaly) */
-- 삭제이상
DELETE FROM Summer WHERE sid = 200;

-- C강좌 수강료 찾을 수 없음
SELECT price
  FROM Summer
 WHERE class LIKE '%C%';

-- 삽입이상
INSERT INTO Summer VALUES (NULL, 'C++', 25000); -- SID 키가 되야함

SELECT COUNT(*)
  FROM Summer;
  
SELECT COUNT(sid)
  FROM Summer;
  
-- 수정이상
-- JAVA 강좌 수강료를 20000원에서 15000원으로 수정
UPDATE Summer
   SET price = 15000
 WHERE Sid = 100;
 
SELECT *
  FROM Summer;
  
DELETE FROM Summer;