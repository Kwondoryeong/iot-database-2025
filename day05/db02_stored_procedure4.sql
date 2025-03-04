-- 5-4 Orders 테이블의 판매 도서에 대한 이익금을 계산하는 프로시저
DELIMITER //
CREATE PROCEDURE GetInterest()

BEGIN
	-- 변수 선언
    DECLARE myInterest INTEGER DEFAULT 0.0;
    DECLARE price INTEGER;
    DECLARE endOfRow BOOLEAN DEFAULT FALSE;
    DECLARE InterestCursor CURSOR FOR
			SELECT saleprice FROM Orders;
	DECLARE CONTINUE handler -- 커서 종료 핸들러 선언
			FOR NOT FOUND SET endOfRow=TRUE; -- 더 이상 읽을 데이터가 없을 경우(NOT FOUND 발생 시) endOfRow 값을 TRUE로 설정하여 루프를 종료
	OPEN InterestCursor;
	cursor_loop: LOOP -- 커서를 돌기 위한 루프
		FETCH InterestCursor INTO price; -- SELECT saleprice from Orders의 테이블 한 행씩 읽어서 값을 price에 집어넣는다.
        IF endOfRow THEN LEAVE cursor_loop;	-- break;
        END IF;
        IF price >= 30000 THEN -- 판매가 3만원 이상이면 10% 이윤을 챙기고, 그 이하면 5% 이윤을 챙기자
			SET myInterest = myInterest + price * 0.1;
		else
			SET myInterest = myInterest + price * 0.05;
		END IF;
	END LOOP cursor_loop;
    CLOSE InterestCursor; -- 커서 종료
    SELECT CONCAT('전체 이익 금액=', myInterest) AS 'Interest';	
END;
//

/* Interest 프로시저를 실행하여 판매된 도서에 대한 이익금을 계산 */
CALL GetInterest();
