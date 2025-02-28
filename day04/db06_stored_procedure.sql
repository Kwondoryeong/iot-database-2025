-- 5-2 동일도서를 파악 후 있으면 도서가격 변경, 없으면 삽입하는 프로시져
delimiter //
CREATE PROCEDURE BookInsertOrUpdate(
	mybookid		INTEGER,
    mybookname		VARCHAR(40),
    mypublisher		VARCHAR(40),
    myprice			INTEGER
)
BEGIN
	/* 변수 선언, 프로시져 안에서는 DECLARE로 선언 */
	DECLARE mycount INTEGER;
    -- 1. 데이터가 존재하는 수를 mycount 변수에 할당
    SELECT COUNT(*) INTO mycount 
      FROM Book
	 WHERE bookname LIKE CONCAT('%', mybookname, '%'); -- 정확한 방법
		-- WHERE bookname LIKE mybookname;
	-- 2. mycount가 0보다 크면 동일 도서 존재
    IF mycount > 0 THEN
		SET SQL_SAFE_UPDATES=0; /* DELETE, UPDATE 연산에 필요한 설정문 */
        UPDATE Book SET price = myprice
         WHERE bookname LIKE CONCAT('%', mybookname, '%');
	ELSE
		INSERT INTO Book(bookid, bookname, publisher, price)
			 VALUES (mybookid, mybookname, mypublisher, myprice);
	END IF;
END;
//

-- 1번째 실행
CALL BookInsertOrUpdate(33, '스포츠 즐거움', '마당과학서적', 25000);
SELECT * FROM Book;
CALL BookInsertOrUpdate(33, '스포츠 즐거움', '마당과학서적', 45000);