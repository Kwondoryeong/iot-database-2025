-- 동시성 제어
-- 자동커밋 해제
START TRANSACTION;

SELECT * FROM Book;

UPDATE Book SET
	   price = 48000
 WHERE bookid = 98;
 
COMMIT;