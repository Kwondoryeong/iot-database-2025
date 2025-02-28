-- 행번호
-- 4-11 고객목록에서 고객번호, 이름, 전화번호를 앞의 2명만 출력하시오.
SET @seq := 0; -- 변수선언 SET 시작 @를 붙임. 값할당 ':=' ('=' 아님) 
SELECT (@seq := @seq + 1) AS '행번호'
	 , custid
     , name
     , phone
  FROM Customer
 WHERE @seq < 2;
 
SELECT custid
     , name
     , phone
  FROM Customer LIMIT 2; -- OR LIMIT (2) 순차적 일부 데이터 추출에 탁월

SELECT custid
     , name
     , phone
  FROM Customer LIMIT 2 OFFSET 3; -- OFFSET n : n+1 행부터 2개 추출
  
  
SELECT custid
     , name
     , phone
  FROM Customer
 WHERE custid <= 2
 ORDER BY custid;

