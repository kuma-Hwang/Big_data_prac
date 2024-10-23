  
  --아이디가 100인 직원
  SELECT *
  FROM employees
  WHERE employee_id = 100;
  
  --이름이 데이비드인 직원
  SELECT *
  FROM employees
  WHERE first_name = 'David';
  
  --사원 아이디가 105이상인 직원의 정보
  SELECT *
  FROM employees
  WHERE employee_id >= 105;
  
  --salary가 10,000이상이고 20,000 이하인 직원의 정보
  SELECT *
  FROM employees
  WHERE salary BETWEEN 10000 AND 20000;
  
  --salsry가 10000, 17000, 24000인 직원 정보
  SELECT *
  FROM employees
  WHERE salary IN(10000,17000,24000);
  
  --job_id값이 AD인 모든(%) 데이터 출력
  SELECT *
  FROM employees
  WHERE job_id LIKE 'AD%';
  
  -- AD로 시작하면서 뒤로 따라오는 문자열이 3자리인 데이터 출력
  SELECT *
  FROM employees
  WHERE job_id LIKE 'AD___';
  
  -- manager_id가 null인 직원 정보
  SELECT *
  FROM employees
  WHERE manager_id IS NULL;
  
  -- (논리연산자) salary가 4000을 초과하면서 job_id가 IT_PROG인 값을 조회
  SELECT *
  FROM employees
  WHERE salary > 4000 AND job_id = 'IT_PROG';
  
  -- (논리연산자) salary가 4000을 초과하면서 job_id가 IT_PROG 이거나 FI_ACCOUNT인 경우
  SELECT *
  FROM employees
  WHERE salary > 4000 
  AND job_id = 'IT_PROG'
  OR job_id = 'FI_ACCOUNT';
  
  --직원번호가 105가 아닌 직원만 출력
  SELECT *
  FROM employees
  WHERE employee_id <> 105;
  
  ------------------------------------------------------------------------------------------
  
  --SQL 함수
  
  --last_nam을 소문자와 대문자를 출력하고  email의 첫번째 문자를 대문자로 출력
  SELECT last_name,
  lower(last_name) Lower적용,
  upper(last_name) Upper적용,
  email,
  initcap(email) Intcap적용
  from employees;
  
  --job_id 데이터 값의 첫째 자리부터 시작해서 두 개의 문자를 출력
  SELECT job_id, substr(job_id,1,2)
  FROM employees;
  
  --job_id 문자열 값이 ACCOUNT이면 ACCNT로 변경해서 출력
    SELECT job_id, replace(job_id,'ACCOUNT', 'ACCNT') 적용결과
    FROM employees;
    
-- first_name에 대해 12자리의 문자열 자리를 만들되
-- first_name의 데이터 값이 12보다 작으면 왼쪽부터 *채워 출력
--(특정 문자로 채우기 <LPAD적용결과 - 오른쪽 RPAD>)
SELECT first_name, LPAD (first_name, 12, '*')
FROM employees;

--자르기(LTRIM,RTRIM,TRIM)
SELECT 'start'||'     - space -     '||'end'
FROM dual;

--좌우 공백제거
--dual 테이블은 더미(dummy)임.
SELECT 'start'||trim('     - space -     ')||'end'
FROM dual;

--자리올림 (salary를 30일로 나눈 후 나눈 값의 소수점 첫째 자리, 소수점 둘째 자리, 정수 첫째 자리에서 반올림 한 값을 출력)
SELECT salary/30 일급,
       round(salary/30, 0) 적용결과_0,
       round(salary/30, 1) 적용결과_1,
       round(salary/30, -1) 적용결과_마이너스
FROM employees;

--절삭 (salary를 30일로 나눈 후 나눈 값의 소수점 첫째 자리, 소수점 둘째 자리, 정수 첫째 자리에서 절삭한 값을 출력)
SELECT salary,
       salary/30 일급,
       trunc(salary/30, 0) 적용결과_0,
       trunc(salary/30, 1) 적용결과_1,
       trunc(salary/30, -1) 적용결과_마이너스
FROM employees;

-- 날짜계산 - 오늘날짜,더하기 1, 빼기1, 특정날짜 빼기,시간더하기
SELECT to_char(sysdate, 'YY/MM/DD/HH24:MI') 오늘날짜,
              sysdate + 1 더하기_1,
              sysdate - 1 빼기_1,
              to_date('20241205') - to_date('20021201') 날짜빼기,
              sysdate + 13/24 시간더하기
FROM dual;

--두 날짜 사이의 개월 수 계산
--department_id가 100인 직원에 대해 오늘날짜, hire_date, 오늘 날짜와 hire_date 사이의 개월 수 출력
SELECT department_id,
       sysdate, hire_date, months_between(sysdate, hire_date)
FROM employees
WHERE department_id = 100;

--employee_id가 100과 106사이인 직원의 hire_date에 3개월 더한 값, hire_date에 3개월 뺀 값.
SELECT hire_date,
       add_months(hire_date, 3) 더하기_적용결과,
       add_months(hire_date, -3) 빼기_적용결과
FROM employees
WHERE department_id = 100;

--NVL : NULL 값 처리
--할당되지 않거나 알려져 있지 않아 적용이 불가능한 값
-- 0이나 공백(space)과는 다름.
-- null 값을 포함한 산술 연산의 결과는 null임.

SELECT salary * commission_pct
FROM employees
order by commission_pct;

-- salay에 commission_pct를 곱하되 commission_pct가 null일 때는 1로 치환하여 commission_pct를 곱한 결과를 출력
-- null값 NVL 처리
SELECT salary * NVL(commission_pct, 1)
FROM employees
ORDER BY commission_pct;

--first_name, last_name, department_id, salary를 출력하되 department_id가 60인 경우에는
-- 급여를 10% 인상한 값을 계산하여 출력하고 나머지 경우에는 원래의 값을 출력 그리고
-- department_id가 60인 경우 10% 인상을 출력하고 나머지 경우에는 미인상을 출력

--DECODE 사용
SELECT first_name,
       last_name,
       department_id,
       salary 원래_급여,
       decode(department_id, 60, salary * 1.1, salary) 조정된급여,
       decode(department_id, 60,'10%인상','미인상') 인상여부
       
FROM employees;

--DECODE를 case로 변환
SELECT first_name,
       last_name,
       department_id,
       salary 원래_급여,
       case department_id  when 60 then  salary * 1.1  else salary end 조정된급여,
       case department_id  when 60 then '10%인상' else '미인상' end 인상여부
       
FROM employees;



