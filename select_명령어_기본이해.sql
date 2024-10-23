select employee_id, first_name, last_name
from employees;

-- employee_id를 기준으로 내림차순 정렬
select employee_id, first_name, last_name
from employees 
order by employee_id desc;


-- job_id 출력

SELECT DISTINCT job_id
from employees;


--필드명 변경 (AS)
select employee_id as 사원번호, first_name as 이름, last_name as 성
from employees;

select employee_id 사원번호, first_name 이름, last_name 성
from employees;

--성 이름 같이 붙여서 출력(||) - 연결연산자
select employee_id 사원번호, first_name||' '||last_name 사원이름
from employees;


--성 이름 같이 붙여서 출력(||) & 이메일 주소 출력 - 연결연산자
select employee_id 사원번호, first_name||' '||last_name 사원이름, email || '@company.com' 이메일
from employees;


