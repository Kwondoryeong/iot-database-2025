-- 기존테이블 삭제
DROP TABLE if exists NewBook;
select * from NewBook;

-- 테이블 생성
create table NewBook (
	bookid INTEGER auto_increment primary key,
    bookname Varchar(100),
    publisher varchar(100),
    price INTEGER
);

-- 500만건 더미데이터 생성
SET SESSION cte_max_recursion_depth = 5000000;

-- 더미데이터 생성
insert into NewBook (bookname, publisher, price)
with recursive cte(n) as
(
	select 1
    union all
    select n+1 from cte where n < 5000000
)
select concat('Book', lpad(n, 7, '0')) -- Book5000000 까지 만듬
	 , concat('Comp', lpad(n, 7, '0'))
     , floor(3000 + rand() * 30000) as price -- 책가격 3000~33000
  from cte;
  
-- 데이터 확인
select Count(*) from NewBook;

select *
  from NewBook
 where price in (8123, 1234, 5679, 22222);
 
-- 인덱스 생성
create index idx_book on NewBook(price);