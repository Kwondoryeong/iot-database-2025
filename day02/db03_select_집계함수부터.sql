-- 3-15 : 고객이 주문한 도서의 총판매액을 구하시오.
SELECT SUM(saleprice) AS 총매출
  FROM Orders;

-- MySQL 문자열은 ' 홑따옴표 사용, " 쌍따옴표 사용불가
-- 3-16 : 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice) AS 총매출, Count(saleprice) AS 구매건수
  FROM Orders
 WHERE custid = 2;

-- 3-17 고객이 주문한 도서의 총판매액, 평균값, 최저, 최고가를 구하시오
-- Ctrl + L : 한줄지우기
SELECT sum(saleprice) AS Total		-- 합계
	 , AVG(saleprice) AS Average	-- 평균
     , MIN(saleprice) AS MinPrice	-- 최소값
     , MAX(saleprice) AS MaxPrice	-- 최대값
     , STD(saleprice) AS StandardV	-- 표준편차
  FROM Orders;

-- 3-18 마당서점의 총 도서 판매 건수를 구하시오.
SELECT COUNT(*) AS 판매건수
  FROM Orders;

-- 그룹화 GROUP BY 키워드 사용
-- 3-19 고객별로 주문한 도서의 총수량과 총판매액을 구하시오.
-- GROUP BY를 사용하면 반드시 집계함수 및 GROUP BY에 포함된 컬럼이 SELECT 안에 들어가 있어야 함
-- GROUP BY에 있는 컬럼만 SELECT 안에 사용할 수 있음. 그 외 사용불가

SELECT custid
	 , Count(*) AS 도서수량 -- 함수 매개변수로 *, custid
     , SUM(saleprice) AS 총판매액
  FROM Orders
GROUP BY custid; -- 집계를 내기 위한 기준이 되는 값 사용 가능

-- 추가 : 3-19의 내용에서 고객별 총액을 내림차순으로 출력하시오.

SELECT custid
	 , Count(*) AS 도서수량 -- 함수 매개변수로 *, custid
     , SUM(saleprice) AS 고객별총액
  FROM Orders
GROUP BY custid
ORDER BY 1 DESC; -- 인덱스로 하는법
-- ORDER BY 고객별총액 DESC;

-- 3-20 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문도서의 총수량을 구하시오.
-- 단, 2권이상 구매한 고객에 대해서만 한정합니다.
-- COUNT() 등 집계함수는 WHERE에 넣을 수 없음
SELECT custid
	 , count(*) AS 총수량
  FROM Orders
 WHERE saleprice >= 8000
 GROUP BY custid
HAVING 총수량 >= 2; -- COUNT(*)와 별명을 사용할 수 있음.

-- 추가 : 고객별 구매수량과 구매총액을 출력하고, 전체를 합산하여 통계를 표시하세요.
SELECT custid
	 , Count(*) AS 도서수량 -- 함수 매개변수로 *, custid
     , SUM(saleprice) AS 총판매액
  FROM Orders
GROUP BY custid 
  WITH ROLLUP;	-- 모든 값 합쳐서 결과 내주는 함수
  
-- JOIN : 두개 이상의 테이블을 합쳐서 출력
-- 3-21 : 고객과 고객의 주문에 관한 데이터를 모두 나타내시오.
SELECT *
  FROM Customer
 INNER JOIN Orders
	ON Customer.custid = Orders.custid;
    
SELECT *
  FROM Customer, Orders
 WHERE Customer.custid = Orders.custid;
 
-- 중복되거나 필요없는 컬럼은 제거하고 출력
SELECT Customer.custid
	 , Customer.name
     , Customer.address
     , Orders.orderid
     , Orders.saleprice
     , Orders.orderdate
  FROM Customer, Orders
 WHERE Customer.custid = Orders.custid;
 
 -- 테이블명을 줄여서 별명으로 사용
 SELECT c.custid
	  , c.name
      , c.address
      , o.orderid
      , o.saleprice
      , o.orderdate
  FROM Customer AS c, Orders AS o
 WHERE c.custid = o.custid;
 
 -- 필요하면 테이블 조인하면 됨
SELECT c.custid
  , c.name
  , c.address
  , o.orderid
  , o.saleprice
  , o.orderdate
  , b.bookname
  , b.publisher
  , b.price
FROM Customer AS c, Orders AS o, Book AS b
WHERE c.custid = o.custid
AND b.bookid = o.bookid;

-- 3-22 고객과 고객 주문에 관한 데이터를 고객별로 정렬하여 나타내시오.
SELECT c.*
	 , o.*
FROM Customer AS c, Orders AS o
WHERE c.custid = o.custid
ORDER BY c.name ASC;

-- 3-23 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT name, saleprice
  FROM Customer AS c, Orders AS o
 WHERE c.custid = o.custid;
 
 -- 3-24 고객별로 주문한 모든 도서의 총판매액을 구하고, 고객별로 정렬하시오.
SELECT name
	 , SUM(saleprice) AS 총판매액
  FROM Customer AS c, Orders AS o
 WHERE c.custid = o.custid
GROUP BY c.name
ORDER BY c.name;

-- 3-25 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
SELECT c.name, b.bookname
  FROM Customer AS c, Orders AS o, Book AS b
 WHERE c.custid = o.custid AND o.bookid = b.bookid;

-- 3-26 가격이 20000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT c.name
	 , b.bookname
  FROM Customer AS c, Orders AS o, Book AS b
 WHERE c.custid = o.custid
   AND o.bookid = b.bookid -- (INNER) JOIN을 위한 조건 
   AND b.price = 20000; -- 나머지 조건들
   
-- 외부조인 : 조건을 만족하지 않는(일치하지 않는) 데이터도 출력이 필요할 때 사용하는 조인
-- 3-27 : 도서를 구매하지 않은 고객을 포함해 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
-- LEFT OUTER JOIN 또는 RIGHT OUTER JOIN - LEFT, RIGHT 는 기준이 되는 테이블 위치
SELECT *
  FROM Customer AS c
  LEFT OUTER JOIN Orders AS o -- Customer 테이블(왼쪽) 기준으로 Orders 테이블과 조인하는데 조건에 맞지않는 것(Order테이블에 없는 것)도 출력 						
  -- LEFT JOIN Orders AS o
    ON c.custid = o.custid;   -- 5. 박세리 경우 phone은 데이터가 없어서 null, orderid~orderdate 는 쿼리문이 만들어낸 것(주문내역없음)
							  -- LEFT OUTER JOIN == LEFT JOIN, INNER JOIN은 LEFT, RIGHT 조인 없음
SELECT *
  FROM Customer AS c
  RIGHT JOIN Orders AS o -- 기준테이블 = 부모테이블
    ON c.custid = o.custid; 
	
-- 서브쿼리(부속질의)
SELECT MAX(price)
  FROM Book;
  
SELECT *
  FROM Book
 WHERE price = 35000;
 
-- 두 쿼리 합치면

SELECT Bookname
  FROM Book
 WHERE price = (
	SELECT MAX(price)
      FROM Book
 );
 
-- 3-29 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
SELECT c.name
  FROM Customer AS c
 WHERE c.custid IN (								-- IN 사용해야함 
				SELECT DISTINCT custid FROM Orders
				 );

-- 3-30 대한미디어에서 출판한 도서를 구매한 고객의 이름을 나타내시오.
-- 고객의 이름이 메인
SELECT c.name
  FROM Customer AS c
 WHERE c.custid IN(	SELECT o.custid
					  FROM Orders AS o
					 WHERE o.bookid IN (
										SELECT b.bookid  -- * 안됨 bookname, publisher 등 때문
										  FROM Book AS b
										 WHERE b.publisher = '대한미디어'
										)
				   );
                   
 -- 1. 대한미디어에서 출판한 도서의 bookid 구한 후 2. booid를 주문한 고객의 custid를 구함 3. custid에 대한 name을 구함
 -- 서브쿼리는 조인으로 바꿀 수 있음( for <-> while 바꿀 수 있는 것 처럼)
 
 -- 3-30 조인으로 변경가능(SubQuery <--> Join)
SELECT c.name
  FROM Customer AS c, Book AS b, Orders AS o
 WHERE c.custid = o.custid
   AND b.bookid = o.bookid
   AND b.publisher = '대한미디어';
   
-- 3-31 출판사별로 출판사의 평균도서가격보다 비싼 도서를 구하시오.
-- 상관 서브쿼리
SELECT *
  FROM Book AS b1
 WHERE (b1.publisher, b1.price) -- IN은 그 값이 포함된 값 찾는 것

SELECT AVG(b2.price)
			   FROM Book AS b2
			  GROUP BY b2.publisher;
SELECT *
  FROM Book AS b1
 WHERE b1.price > (
			SELECT AVG(b2.price)
			  FROM Book AS b2
			 WHERE b2.publisher = b1.publisher );

SELECT AVG(b2.price)
	 , b2.publisher
  FROM Book AS b2
 WHERE b2.publisher = '대한미디어'
 GROUP BY b2.publisher;
 
 -- 집합연산 
SELECT name
  FROM Customer
UNION
SELECT bookname
  FROM Book;

SELECT name
  FROM Customer
UNION ALL
SELECT bookname
  FROM Book;

-- EXISTS : 상관서브쿼리에서 사용하는 키워드, 상관서브쿼리가 아니라도 사용가능
-- 3-33 주문이 있는 고객의 이름과 주소를 나타내시오.
SELECT *
  FROM Customer AS c
 WHERE EXISTS ( 
			SELECT o.custid -- 필요한 컬럼하거나 *
			  FROM Orders AS o
			 WHERE o.custid = c.custid -- 메인 쿼리의 컬럼이 서브쿼리에 사용되고 있음 (상관 부속질의)
			  );