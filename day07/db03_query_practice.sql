-- WorkBook : SQL Practice
/* 샘플 - Employee에서 사원번호, 이름, 급여, 업무, 입사일, 상사의 사원번호를 출력하시오. 
		  이때 이름과 성을 연결하여 Full Name이라느느 별칭으로 출력하시오. (107행)
*/
select * from employees;
select employee_id
	 , concat(first_name, ' ', last_name) as 'full name'
     , salary
     , job_id
     , hire_date
     , manager_id
  from employees;
  
/* 문제1 - employee 에서 사원의 성과 이름을 Name, 업무는 Job, 급여는 Salary, 연봉에 $100달러 보너스를 추가하여 계산한 값은 Increased Ann_salary,
		   급여에 $100 보너스를 추가하여 계산한 연봉은 Increased Salary라는 별칭으로 출력하시오.(107행)
*/           

select concat(first_name, ' ', last_name) as 'Name'
     , job_id as 'job'
     , salary as 'Salary'
     , (salary * 12) + 100 as 'Increased Ann_Salary'
     , salary + 100 as 'Increased Salary'
  from employees
 order by Salary;
 
/* 문제2 - employee 에서 모든 사원의 이름(last_name)과 연봉을 '이름: 1 Year Salary = $연봉' 형식으로 출력하고, 1 Year Salary 라는 별칭으로 붙여 출력하시오.(107행)
*/
select concat(last_name, ': 1 Year Salary = $', (salary * 12)) as '1 Year Salary'
  from employees;
  
/* 문제3 - 부서별로 담당하는 업무를 한 번씩만 출력하시오.(20행)
*/
select * from employees;
select DISTINCT department_id, job_id
  from employees;

-- where, order by
/* 샘플 - HR 부서에서 예산 편성 문제로 급여 정보 보고서를 작성하려고 한다. 사원 정보(Employees) 테이블에서 급여가 
		   $7,000 ~ $10,000 범위 이외인 사람의 성과 이름(Name으로 별칭) 및 급여를 급여가 작은 순서로 출력하시오.(75행)
*/
select concat(first_name, ' ', last_name) as 'Name', salary
  from employees
 where salary not between 7000 and 10000
 order by salary;
 
/* 문제1 - 사원의 성(last_name) 중에 'e' 및 'o' 글자가 포함된 사원을 출력하시오. 이때 머리글은 e AND o Name이라고 출력하시오.(10행)
*/
select last_name as 'e AND o Name' 
  from employees
 where last_name like '%e%' and last_name like '%o%'; 
 
/* 문제2 - 현재 날짜 타입을 날짜 함수를 통해 확인하고, 1995년 5월 20일부터 1996년 5월 20일 사이에 고용된 사원들의 이름(Name으로 별칭),
		  사원번호, 고용 일자를 출력하시오. 단, 입사일이 빠른 순으로 정렬하시오.(8행)
*/
select date_add(sysdate(), interval 9 hour) as 'sysdate()';
select sysdate();
select last_name as 'Name'
	 , employee_id
     , hire_date
  from employees
 where hire_date between '1995-05-20' and '1996-05-20' -- date 타입은 문자열처럼 조건 연산을 해도 됨
 order by hire_date ASC;
 
/* 문제3 - HR 부서에서는 급여(salary)와 수당률(commission_pct)에 대한 지출 보고서를 작성하려고 한다.
		   수당을 받는 모든 사원의 성과 이름(Name으로 별칭), 급여, 업무, 수당률을 출력하시오.
           이때 급여가 큰 순서대로 정렬하되, 급여가 같으면 수당율이 큰 순서대로 정렬하시오.(35행)
*/
select * from employees;
select concat(fisrt_name, ' ', last_name) as 'Name', Salary, job_id, commission_pct
  from employees
 where salary > 0
 order by salary;
 
/* 샘플 - 이번 분기에 60번 IT부서에서는 신규 프로그램을 개발하고 보급하여 회사에 공연하였다. 
		  이에 해당 부서의 사원 급여를 12.3% 인상하기로 하였다. 60번 IT 부서 사원의 급여를 12.3% 인상하여
          정수만(반올림) 표시하는 보고서를 작성하시오. 출력 형식은 사번, 이름과 성(Name으로 별칭), 급여, 인상된 급여(Increased Salary로 별칭) 순으로 출력한다.(5행)
*/
select * from employees;
select employee_id
	 , concat(first_name, ' ', last_name) as 'Name'
	 , round(salary) as 'Salary'
	 , round(salary * 1.123) as 'Increased Salary'
  from employees
 where department_id = 60;


-- 단일행 함수 및 변환 함수
/* 문제1 - 이름이 's'로 끝나는 각 사원의 이름과 업무를 아래의 예와 같이 출력하고자 한다. 출력 시 성과 이름은 첫 글자를 대문자로,
		   업무는 모두 대문자로 출력하고 머리글은 Employee JOBs.로 표시하시오.(18행)
*/
select concat(first_name, ' ', last_name, ' is a ', UPPER(job_id)) as 'Employee JOBs.'
  from employees
 where last_name like '%s';
 
 /* 문제2 - 모든 사원의 연봉을 표시하는 보고서를 작성하려고 한다. 보고서에 사원의 성과 이름(Name으로 별칭), 급여, 수당 여부에 따른 연봉을 포함하여 출력하시오.
			수당 여부는 수당이 있으면 'Salary + Commission', 수당이 없으면 'Salary only'라고 표시하고, 별칭은 적절히 붙인다.
            또한 출력시 연봉이 높은 순으로 정렬한다.(107행)
*/
select * from employees;
select concat(first_name, ' ', last_name) as 'Name', salary, (salary * 12) as 'Annual Salary', if(isnull(commission_pct), 'Salary + Commission', 'Salary only') as 'commission ?'
  from employees
 order by salary desc;
  
  
/* 문제3 - 모든 사원의 성과 이름(Name으로 별칭), 입사일, 입사한 요일을 출력하시오. 이때 주(week)의 시작인 일요일부터 출력되도록 정렬하시오.(107행)
*/
select concat(first_name, ' ', last_name) as 'Name'
	 , hire_date
     , date_format(hire_date, '%W') as 'Day of the Week'
  from employees
 order by date_format(hire_date, '%w'), hire_date; -- sunday = 0, %w : 숫자0부터. %W : 금요일부터
 
 -- 집계 함수
 /* 샘플 - 모든 사원은 직속 상사 및 직속 직원을 갖는다. 단, 최상위 또는 최하위 직원은 직속 상사 및 직원이 없다.
		   소속된 사원 중 어떤 사원의 상사로 근무 중인 사원의 총수를 출력하시오.(1행)
*/
select count(distinct manager_id) 'count Managers'
  from employees;

/* 문제1 - 각 사원이 소속된 부서별로 급여 합계, 급여 평균, 급여 최댓값, 급여 최솟값을 집계하고자 한다.
		   계산된 출력 값은 여섯 자리와 세자리 구분 기호, $ 표시와 함께 출력하고 부서 번호의 오름차순으로 정렬하시오.
           단, 부서에 소속되지 않은 사원에 대한 정보는 제외하고, 출력 시 머리글은 아래 풀이처럼 별칭(alias) 처리하시오.(11행)
*/
select department_id
	 , concat('$', format(round(sum(salary),0),0)) as '급여 합계'
     , concat('$', format(round(avg(salary), 1),1)) as '급여 평균' -- round(값, 1), 소수점 1자리에서 반올림, format(값, 1) 소수점표현 및 1000단위 ,표시
     , concat('$', format(round(max(salary),0),0)) as '급여 최댓값'
     , concat('$', format(round(min(salary),0),0)) as '급여 최솟값'
  from employees
 where department_id is not null
 group by department_id; -- 그룹바이 속한 컬럼만 select 절에 사용할 수 있음

/* 문제2 - 사원들의 업무별 전체 급여 평균이 $10,000보다 큰 경우를 조회하여 업무, 급여 평균을 출력하시오.
		   단 업무에 사원(CLERK)이 포함된 경우는 제외하고 전체 급여 평균이 높은 순서대로 출력하시오.(7행)
*/
select job_id
  from employees;

-- 조인
/* 샘플 - hr 스키마에 존재하는 Employees, Departments, Locations 테이블의 구조를 파악한 후 Oxford에 근무하는 사원의 성과 이름
		  (Name으로 별칭), 업무, 부서명, 도시명을 출력하시오.
          이때 첫 번째 열은 회사명인 'Han-Bit'이라는 상수 값이 출력되도록 하시오.(34행)
*/
 
/* 문제1 - hr 스키마에 있는 employees, Departments 테이블의 구조를 파악안 후 사원 수가 5명 이상인 부서명과 사원 수를 출력하시오.
		   이때 사원 수가 많은 순으로정렬하시오(5행)
*/

/* 문제2 - hr 스키마의 Job_Grades 테이블을 사용하여 각 사원의 급여에 따른 급여 등급을 보고하려고 한다.
		   급여 등급은 Job_Grades 테이블에 표시된다. 해당 테이블의 구조를 살펴본 후 사원의 성과 이름(Name으로 별칭),
		   업무, 부서명, 입사일, 급여, 급여 등급을 출력하시오.(106행)
*/
select * from job_grades;
select * from employees;
select * from jobs;
select * from departments;
 
desc job_grades;
desc employees;
select concat(e.first_name, ' ', e.last_name) as 'Name'
	 , e.job_id
     , d.department_name
     , e.hire_date
     , e.salary
     , (select grade_level from job_grades
		 where e.salary between lowest_sal and highest_sal) as 'grade_level'  -- 서브쿼리 추가
 from departments as d, employees as e 
where d.department_id = e.department_id
order by salary desc;
 
SELECT 
    concat(e.first_name, ' ', e.last_name) as Name,  		 -- 성과 이름을 합쳐서 표시
    e.job_id as Job,                            	 -- 업무
    d.department_name as department,            	 -- 부서명
    format(e.hire_date, 'YYYY-MM-DD') AS hire_date,  -- 입사일 (YYYY-MM-DD 형식)
    e.salary AS salary,                        		 -- 급여
    jg.grade_level					           		 -- 급여 등급
FROM employees e
JOIN departments d 
    ON e.department_id = d.department_id
JOIN job_grades jg 
    ON e.salary BETWEEN jg.LOWEST_SAL AND jg.HIGHEST_SAL  -- 급여에 맞는 등급 찾기
ORDER BY e.salary DESC;

/* 문제3 - 각 사원과 직속 상사와의 관계를 이용하여 다음과 같은 형식의 보고서를 작성하고자 한다.
		   ex) 니나 코차르는 스티븐 킹에게 보고한다. -> Neena Kochhar report to STEVEN KING
           어떤 사원이 어떤 사원에게 보고하는지 위 예를 참고하여 출력하시오. 단, 보고할 상사가 없는 사원이 있다면
           그 정보도 포함하여 출력하고, 상사의 이름은 대문자로 출력하시오.(107행)
*/
select concat(e2.first_name, ' ', e2.last_name) as 'Employee'
	 , 'report to'
     , upper(concat(e2.first_name, ' ', e2.last_name)) as 'Manager'
  from employees as e1 right join employees as e2
	on e1.employee_id = e2.manager_id;
    
-- 서브쿼리
/* 샘플 HR 부서의 어떤 사원은 급여 정보를 조회하는 업무를 맡고 있다. Tucker 사원보다 급여를 많이 받는 사원의 성과 이름(Name으로 별칭), 업무, 급여를 출력하시오.(15행)
*/

/* 문제3 - 사원들의 지역별 근무현황을 조회. 도시 이름이 영문'O'로 시작하는 지역에 살고 있는 사원의 사번, 성과 이름(Name으로별칭), 업무 입사일을 출력하시오.(34행)
*/
select * from countries;
select * from regions;
select * from departments;
select e.department_id
	 , concat(e.first_name, ' ', e.last_name) as 'Name'
     , e.job_id
     , e.hire_date
  from employees as e, departments as d
 where e.department_id = d.department_id
	   and d.location_id = (select location_id
	  from locations
	 where city like 'O%' or city like 'o%');

/* 서브쿼리 테스트 
select location_id
  from locations
 where city like 'O%' or city like 'o%';
*/
