-- 저장 프로그램1
-- Book 테이블에 하나의 row를 추가하는 프로시져
USE madangdb;
delimiter //
CREATE PROCEDURE InsertBook(
	IN myBookId		INTEGER,
    IN myBookName	VARCHAR(40),
    IN myPublisher	VARCHAR(40),
    IN myPrice		INTEGER
)
BEGIN
	INSERT INTO Book(bookid, bookname, publisher, price)
		 VALUES(myBookId, myBookName, myPublisher, myPrice); -- 변수에 @안써도됨
END;
//
delimiter;
SELECT * FROM Book;
-- 프로시저 호출, InsertBook 테스트 부분
CALL InsertBook(31, 'BTS', '하이브', 300000);
CALL InsertBook(32, '봉준호 일대기', 'CJ엔터', 34000);

UPDATE Book
SET bookname = 'BTS PhotoAlbum'
WHERE bookid = 31;

-- 프로시저 삭제
DROP PROCEDURE InsertBook;