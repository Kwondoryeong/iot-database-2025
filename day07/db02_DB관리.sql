-- 데이터베이스 관리
SHOW databases;
select * from sys.sys_config;

-- infomation_schema, performance_schema, mysqal 등은 시스템 DB라서 개발자, DBA 사용하지 않음
use mysql;
use madang;
-- 하나의 DB내 존재하는 테이블들 확인
show tables;

select * from v_orders;

-- 테이블 구조
desc madang.NewBook;

select * from v_orders;

-- 사용자 추가
-- madang 데이터베이스만 접근할 수 있는 사용자 madang 생성
-- 내부접속용
create user madang@localhost IDENTIFIED BY 'madang';
-- 외부접속용
create user madang@'%' identified by 'madang';

-- Administration - 

-- DCL : grant, revoke
-- 데이터 삽입, 조회, 수정만 권한 부여
grant select, insert, update on madang.* to madang@localhost with GRANT OPTION;
grant select, insert, update on madang.* to madang@'%' with GRANT OPTION;

-- 사용자 madang에게 madangDB를 사용할 수 있는 모든 권한 부여
grant all privileges on madang.* to madang@localhost with GRANT OPTION;
grant all privileges on madang.* to madang@'%' with GRANT OPTION;

flush PRIVILEGES;

-- 권한해제
-- madang 사용자의 권한 중 select 권한만 제거
revoke select on madang.* from madang@localhost;
revoke all privileges on madang.* from madang@localhost;