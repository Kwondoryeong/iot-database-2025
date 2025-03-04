-- 사용자 정의함수
-- 저장프로시저와 유사. RETURNS, RETURN 키워드 차이 있음
-- 1행 1열, 스칼라값 리턴
SELECT AVG(price) FROM madang.Book;
SELECT char_length('HELLO WORLD');

DELIMITER //
CREATE FUNCTION fnc_INTEREST(
	price INTEGER
) RETURNS INTEGER
BEGIN
	DECLARE myInterest INTEGER;
    -- 가격이 3만원 이상이면 10% 아니면 5%
    IF price >= 30000 THEN SET myInterest = price * 0.1;
    ELSE SET myInterest = price * 0.05;
    END IF;
    RETURN myINTEREST;
END;

-- 실행
SELECT custid, orderid, saleprice, fnc_Interest(saleprice) AS '이익금'
	FROM Orders;
