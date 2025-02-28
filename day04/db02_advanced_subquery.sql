-- 서브쿼리 고급
-- 4-12 Orders 테이블 평균 주문금액 이하의 주문에 대해 주문번호와 금액을 나타내시오
-- 집계함수는 GROUP BY가 없어도 테이블 전체를 집계할 수 있음
-- GROUP BY를 사용하려면 집계함수가 있어야함

-- 순서 : 먼저 전체 실행,
-- 문제 : 평균주문 -> 집계함수 사용
-- 집계함수 사용한 것 서브쿼리로 넣기, 조회 컬럼 정리
SELECT orderid
	 , saleprice
  FROM Orders
 WHERE saleprice <= ( SELECT ROUND(AVG(saleprice)) AS '평균주문금액'
					    FROM Orders
					);

-- 4-13 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 나타내시오.
SELECT orderid, custid, saleprice
  FROM Orders od1
 WHERE saleprice >= (SELECT ROUND(AVG(saleprice)) AS '평균주문금액'
					   FROM Orders od2
                      WHERE od1.custid = od2.custid
					);
                     


-- 4-14 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오.
SELECT SUM(saleprice) AS '대한민국 고객 총 판매액'
  FROM Orders
 WHERE custid IN (SELECT custid
				    FROM Customer
				   WHERE address LIKE '%대한%'
				  );
                  
-- 4-15 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의
-- 주문번호와 판매금액을 보이시오.
-- 비교연산자만 사용시 서브쿼리의 값이 단일 값이 되어야함 (제약사항)
SELECT *
  FROM Orders
 WHERE saleprice > (SELECT MAX(saleprice)
					  FROM Orders
				     WHERE custid = '3');
-- ALL|SOME|ANY 사용시 서브쿼리 값이 단일 값이 아니어도 상관없음 (느슨)
-- ALL은 서브쿼리 내 결과의 모든 값과 비교연산이 일치하는 값 찾는 것 (EX 결과값이 2개 이상)
-- SOME|ANY - 서브쿼리 내 결과의 각각의 값과 비교연산이 일치하는 값을 찾는 것
SELECT *
  FROM Orders
 WHERE saleprice > ALL (SELECT saleprice -- ALL 사용 시 다중 값 찾기 가능
					      FROM Orders
				         WHERE custid = '3');
                         
-- 4-16 EXISTS 연산자를 사용하여 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오
SELECT SUM(saleprice) AS '총판매액'
  FROM Orders o
 WHERE EXISTS (SELECT *
				 FROM Customer AS c
			    WHERE address LIKE '%대한민국%' 
                  AND c.custid = o.custid
			  );
-- 추가. 최신방법(서브쿼리에서 두가지 컬럼을 비교하는 법) - 튜플(파이썬과 동일)
SELECT *
  FROM Orders
 WHERE (custid, orderid) IN (SELECT custid, orderid
							   FROM Orders
							  WHERE custid = 2);

-- SELECT 서브쿼리, 스칼라값(단일행, 단일열) 한컬럼에 데이터 1개
-- 4-17 마당서점의 고객별 판매액을 나타내시오(고객이름과 고객별 판매액 출력)
-- SELECT 서브쿼리는 스칼라값
-- 함수 때문에 새로 만들어진 컬럼은 없기 때문에 내용 그대로가 컬럼명으로 출력(AS사 용)
SELECT o.custid
	 , (SELECT name FROM Customer WHERE custid = o.custid) AS '고객명'
	 , SUM(o.saleprice) '판매액'
  FROM Orders AS o
 GROUP BY custid;
 
-- FROM절 서브쿼리, 인라인뷰
-- 4-19 고객번호가 2이하인 고객의 판매액을 나타내시오.(고객이름, 고객별 판매액 출력)
-- 이 테이블이 하나의 가상의 테이블이 됨
-- 1. 이 테이블이 하나의 가상 테이블이 됨
SELECT custid
	 , name
  FROM Customer
 WHERE custid <= 2;
-- 2. 위 가상테이블을 cs라고 이름짓고 , FROM에 넣어줌
 SELECT *
   FROM (
		SELECT custid
			 , name
		FROM Customer
		WHERE custid <= 2) AS cs;
-- 3. 가상테이블 cs와 Orders 테이블 조인
SELECT cs.name, SUM(o.saleprice) AS '구매액'
  FROM (
		SELECT custid
			 , name
		FROM Customer
		WHERE custid <= 2) AS cs, Orders AS o
 WHERE cs.custid = o.custid
 GROUP BY cs.name;