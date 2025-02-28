-- 인덱스
-- DDL로 인덱스 생성
-- 4-24 Book테이블의 bookname에 인덱스 ix_Book을 생성하시오.
CREATE INDEX ix_Book ON Book(bookname);

-- 4-25 Book테이블에 publisher, price를 인덱스 ix_Book2를 생성하시오.
CREATE INDEX ix_Book2 ON Book(publisher, price);

-- 추가 : SHOW INDEX FROM
SHOW INDEX FROM Book;

-- 인덱스가 제대로 동작하는지 확인
-- 실행계획(Explain Current Statement) - 인덱스나 조인등에서 쿼리중 어디에서 가장 처리비용이 가장 많이 발생하는지
SELECT *
  FROM Book
 WHERE publisher = '대한미디어'
   AND price >= 30000;

-- 4.26 BOok 테이블 인덱스를 최적화하시오.
ANALYZE TABLE Book;

-- 4-27 인덱스 ix_Book을 삭제하시오.
DROP INDEX ix_Book2 ON Book;

-- SQL로 구구단 작성하기
SELECT
	CONCAT(b.b, ' x ', a.a, ' = ', a.a * b.b)		"2단",
    CONCAT(c.c, ' x ', a.a, ' = ', a.a * c.c)		"3단",
    CONCAT(d.d, ' x ', a.a, ' = ', a.a * d.d)		"4단",
    CONCAT(e.e, ' x ', a.a, ' = ', a.a * e.e)		"5단",
    CONCAT(f.f, ' x ', a.a, ' = ', a.a * f.f)		"6단",
    CONCAT(g.g, ' x ', a.a, ' = ', a.a * g.g)		"7단",
    CONCAT(h.h, ' x ', a.a, ' = ', a.a * h.h)		"8단",
    CONCAT(i.i, ' x ', a.a, ' = ', a.a * i.i)		"9단"
FROM
	(	SELECT 1 a UNION ALL
    	SELECT 2 a UNION ALL
		SELECT 3 a UNION ALL
		SELECT 4 a UNION ALL
        SELECT 5 a UNION ALL
        SELECT 6 a UNION ALL
        SELECT 7 a UNION ALL
        SELECT 8 a UNION ALL
        SELECT 9 a
	) a
CROSS JOIN
		(SELECT 2 b)	b,
        (SELECT 3 c)	c,
        (SELECT 4 d)	d,
        (SELECT 5 e)	e,
        (SELECT 6 f)	f,
        (SELECT 7 g)	g,
        (SELECT 8 h)	h,
        (SELECT 9 i)	i;