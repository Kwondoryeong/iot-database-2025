-- 내장함수
-- 4-1 -78과 78의 절대값을 구하시오
SELECT ABS(-78), ABS(78);

-- 4-2 4.875를 소수점 첫번째 자리까지 반올림 하시오.
SELECT ROUND(4.875, 1) AS 결과; -- ROUND(수, n) n자리까지 반올림 

-- 4-3 고객별 평균 주문 금액을 100원 단위로 반올림한 값을 구하시오.
-- CEIL 올림, FLOOR 내림, ROUND 반올림, TRUNCATE 버림
SELECT custid, ROUND(SUM(saleprice) / count(*), -2) AS '평균금액'
  FROM Orders
 GROUP BY custid;

-- 문자열 내장함수
-- 4-4 도서 제목에서 야구가 포함된 도서명을 농구로 변경한 후 도서 목록을 출력하시오.
SELECT * FROM Book;

-- 출력시에만 야구->농구로 변경해서 출력(내용 변경X)
SELECT bookid
	 , REPLACE(bookname, '야구', '농구') AS bookname 
     , publisher
     , price
  FROM Book;

-- 추가 CONCAT
SELECT 'Hello' 'MySQL';
SELECT CONCAT('Hello', 'MySQL', 'WOW') AS '문자열 연결';

-- 4-5 굿스포츠에서 출판한 도서의 제목과 제목의 문자 수, 바이트 수를 구하시오.
SELECT bookname AS '제목'
	 , CHAR_LENGTH(bookname) AS '제목 문자 수'	-- 글자 길이를 구할 때
     , LENGTH(bookname) AS '제목 바이트 수' 	-- UTF8에서 한글 한글자의 바이트수는 3Bytes
  FROM Book
 WHERE publisher = '굿스포츠';
 
-- 4-6 고객 중 성이 같은 사람이 몇 명이나 되는지 성(姓)별 인원수를 구하시오.
-- (문자열, 시작 문자 인덱스, 끝 문자 인덱스(길이))
-- DB는 인덱스 1부터 시작
SELECT SUBSTR('권도형', 2, 2) AS '성씨';

SELECT substr(name, 1, 1) AS '성씨'
	 , COUNT(*)
  FROM Customer
 GROUP BY substr(name, 1, 1); -- GROUP BY에 쓴 것 그대로 SELECT문에 올리면 사용 가능
 
-- 추가. trim
SELECT CONCAT('--', TRIM('     Hello!     '), '--') AS 'TRIM'
	 , CONCAT('--', LTRIM('     Hello!     '), '--') AS 'LTRIM'
     , CONCAT('--', RTRIM('     Hello!     '), '--') AS 'RTRIM';
-- 새로 추가된 TRIM() 함수
SELECT TRIM('=' FROM '=== -Hello- ===');
     
SELECT name
  FROM Customer
 GROUP BY name;
 
-- 날짜, 시간 함수
SELECT SYSDATE(); -- Docker의 서버시간 따라서 GMT(그리니치 표준시)를 따름 +9hour

SELECT ADDDATE(SYSDATE(), INTERVAL 9 HOUR) AS '한국시간';

-- 4-7 마당서점은 주문일부터 10일 후에 매출을 확정합니다. 각 주문의 확정일자를 구하시오.
SELECT orderid AS '주문번호'
	 , Orderdate AS '주문일자'
     , ADDDATE(SYSDATE(), INTERVAL 10 DAY) AS '확정일자'
  FROM Orders;

-- 추가 나라별 날짜, 시간을 표현하는 포맷이 다름
SELECT SYSDATE() AS '기본날짜/시간'
	 , DATE_FORMAT(SYSDATE(), '%M/%d/%Y %H:%m:%s');
     
-- 4-8 2014년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 나타내시오.
-- 단, 주문일은 %Y/%m/%d 형태로 표시한다.
-- %Y = 년도전체, %y = 년도 뒤2자리, %M = July(월 이름), %b = Jul(월 약어), %m = 07(월숫자)
-- %d = 일, %H = 24시, %h 12시, %W = Monday, %w = 1(요일은 일요일 0)
-- %p = AM/PM

SELECT orderid AS '주문번호'
	 , DATE_FORMAT(orderdate, '%Y/%m/%d') AS '주문일'
     , custid AS '고객번호'
     , bookid AS '도서번호'
  FROM Orders;
  
-- DATEDIFF : D-day
SELECT DATEDIFF(SYSDATE(), '2025-02-03');

-- Formatting, 1000 단위마다 ',' 넣기
SELECT bookid
	 , FORMAT(price, 0) AS price
  FROM MyBook;

-- NULL = Python None 동일. 모든 다른 프로그래밍 언어에서는 전부 NULL, NUL
-- 추가. 금액이 NULL일 때 발생되는 현상
SELECT price - 5000
  FROM MyBook
 WHERE bookId = 3;

-- 핵심. 집계함수가 꼬임
SELECT SUM(price) AS '합산은 문제없음'
	 , ROUND(AVG(price), 0) AS '평균은 NULL이 빠져서 꼬임'
	 , count(*) AS '모든 행의 갯수는 일치'
     , count(price) AS 'NULL 값은 갯수에서 빠짐'
  FROM MyBook;

-- NULL값 확인. NULL은 비교연산자 (=, <, >, <>, ...) 사용불가
-- IS 키워드 사용
SELECT *
  FROM MyBook
 WHERE price IS NULL; -- 반대는 IS NOT NULL 

-- IFNULL 함수 : NULL인 출력 값 변경 (실제 값 변경X)
SELECT bookid
	 , bookname
     , IFNULL(price, 0) AS price
  FROM MyBook;
     