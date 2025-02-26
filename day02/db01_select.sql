-- SELECT * -- All 이라고 부름. 테이블에 있는 모든 컬럼을 출력
SELECT phone -- 프로젝션
  FROM Customer
 WHERE custid = '2'; -- ;은 생략가능. C, Python 같은 코드로 가져갈 때는 삭제!
