-- 쿼리 3-1 : 모든 도서의 이름과 가격을 검색하시오
 SELECT bookname, price
   FROM Book;
   
-- 워크벤치에서 쿼리 실행할 땐 편함
 SELECT * -- 툴에서 작업하기 편함
   FROM Book;
   
-- 3-2 : 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오
-- 파이썬, C# 등 프로그래밍언어로 가져 갈 때는 컬럼이름, 컬럼갯수 파악해야 하기 때문에 아래와 같이 사용
SELECT bookid, bookname, publisher, price
  FROM Book;
  
-- 3-3 : 도서 테이블의 모든 출판사를 검색하시오
SELECT publisher
  FROM Book;
  
-- 출판사 별로 한 번만 출력 할 시  
-- ALL - 전부, DISTINCT - 중복 제거
SELECT DISTINCT publisher
  FROM Book;
  
-- 3-4 : 도서 중 가격이 20000원 미만인 것을 검색하시오
-- > : 미만, < : 초과, >= : 이하, <= : 이상, <> : 같지않다, != : 같지않다 = 같다 (프로그래밍 언어와 차이)
SELECT *
  FROM Book
 WHERE price < 20000;
 
 -- 3-5 : 가격이 10000원 이상 20000원 이하인 도서를 검색하시오
SELECT *
  FROM Book
 WHERE price between 10000 AND 20000;

SELECT *
  FROM Book   
 WHERE price >= 10000 and price <= 20000;
 
-- 3-6, 3-11 : 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오.
-- 같은 속성에서 여러 개 값 비교는 IN 사용이 좋음
SELECT *
  FROM Book
 WHERE publisher IN ('굿스포츠', '대한미디어');
 
 SELECT *
  FROM Book
 WHERE publisher = '굿스포츠' or publisher = '대한미디어';
 
SELECT *
  FROM Book
 WHERE publisher NOT IN ('굿스포츠', '대한미디어');
 
-- 3-7 : '축구의 역사'를 출간한 출판사를 검색하시오.
SELECT bookname, publisher
  FROM Book
 WHERE bookname = '축구의 역사';

-- 3-8 : 도서이름에 '축구'가 포함된 출판사를 검색하시오.
-- 패턴
-- % 갯수와 상관없이 글자가 포함되는 것
-- [0-5] 1개의 문자가 일치
-- [^] 1개의 문자가 일치하지 않는 것
-- _ 특정위치의 1개의 문자를 포함 _구% : 첫번째 글자 상관없음, 두번째 글자 '구' 세번째 부터는 상관없음
SELECT *
  FROM Book
 WHERE bookname LIKE '%축구%';

SELECT *
  FROM Book
 WHERE bookname LIKE '_구%'; -- _ : 자릿수

SELECT *
  FROM Book
 WHERE bookname regexp '[]%';
 
 
 -- 추가 : 고객중에서 전화번호가 없는 사람을 검색하시오
SELECT *
  FROM Customer
 WHERE phone IS NULL;

SELECT *
  FROM Customer
 WHERE phone IS NOT NULL;
 
-- 3-10 : 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오
SELECT *
  FROM Book
 WHERE bookname LIKE '%축구%' AND price >= '20000';

-- 3-12 : 도시를 이름순으로 검색하시오.
-- ASC(ending) : 오름차순 생략 가능, DESC(ending) : 내림차순
SELECT *
  FROM Book
-- ORDER BY bookname desc;
ORDER BY price;

-- 3-13 : 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오.
SELECT *
  FROM Book
 ORDER BY price, bookname;

-- 3-14 : 도서 가격을 내림차순으로 검색하시오. 가격이 같다면 출판사를 오름차순으로 출력하시오.
SELECT *
  FROM Book
ORDER BY price DESC, publisher;


