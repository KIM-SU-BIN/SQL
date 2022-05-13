/********************
select 문
    selec 절
    from 절
    where 절
    order by 절
********************/
    
-- 모든 컬럼 조회하기
select *
from departments;

-- 원하는 컬럼만 조회하기
SELECT employee_id, first_name, last_name
from employees;

-- 예제
-- 사원의 리음(first_name)과 전화번호 입사일 연봉을 출력하세요
SELECT * first_name, phone_nunber, hire_date, salary
from employees;

--사원의 이름(first_name)과 성, 급여, 전화번호, 이메일, 입사일을 출력하세요
Select first_name "이름",
        phone_number "전화번호",
        hire_date "입사일",
        salary "급여"
 from employees;
    
--사원의 사원번호 이름(first_name)과 성, 급여, 전화번호, 이메일, 입사일을 출력하세요
Select first_name as 이름,
        last_name 성,
        salary "Salary",
        phone_number hp,
        email "이 메 일",
        hire_date 입사일 
from employees;

--연결연산자 (커럼을 붙이기)
select first_name,
        last_name
from employees;

select first_name || last_name
from employees;

select first_name || ' ' || last_name
from employees;

select first_name || ' hire date is ' || hire_date 입사일
from employees;

--산술 연산자
SELECT first_name, salary
FROM employees;

SELECT first_name, salary*12
FROM employees;

select job_id
from employees;

SELECT first_name, 
        salary,
        salary*12,
        (salary+300)*12
FROM employees;

--예제 ppt7
SELECT first_name || last_name,
        salary,
        salary*12,
        salary*12+5000,
        phone_number
FROM employees;

--where절
SELECT first_name
FROM employees
where department_id = 10;

--예제 PPT10
-- 연봉이 15000 이상인 사원들의 이름과 월급을 출력하세요
select first_name, salary
from employees
where salary >= 15000;

--예제 07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요
select first_name, 
        hire_date
from employees
where hire_date >= '07/01/01';

--예제 이름이 Lex인 직원의 연봉을 출력하새요
select salary
from employees
where first_name = 'Lex';

--조건이 2개 이상일 때 한번에 조회하기
--연봉이 14000 이상 17000이하인 사원의 이름과 연봉을 구하시오
SELECT first_name, salary
FROM employees
where salary >=14000
      and salary <=17000;
      
-- 예제 : 입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요
SELECT hire_date, first_name
FROM employees
where hire_date >= '04/01/01'
      and hire_date <= '05/12/31';
      
--BETWEEN 연산자로 특정구간 값 출력하기
--연봉이 14000 이상 17000이하인 사원의 이름과 연봉을 구하시오
SELECT first_name, salary
FROM employees
where salary BETWEEN 14000 and 17000;

--IN 연산자로 여러 조건을 검사하기
SELECT first_name, last_name, salary
FROM employees
where first_name  = 'Neena'
or first_name  = 'John';

where first_name in ('Neena', 'Lex', 'John');

--예제 연봉이 2100, 3100, 4100, 5100 인 사원의 이름과 연봉을 구하시오
--ver.1
SELECT first_name, salary
FROM employees
where salary = 2100
    or salary = 3100
    or salary = 4100
    or salary = 5100;

--ver.2
SELECT first_name, salary
FROM employees
where salary = (2100, 3100, 4100, 5100);

--PPT 14
--Like 연산자로 비슷한 것들 모두 찾기
SELECT first_name, last_name, salary
FROM employees
where first_name like '%s%';

SELECT first_name, last_name, salary
FROM employees
where first_name like 'L%';

-- 이름에 am 을 포함한 사원의 이름과 연봉을 출력하세요
SELECT first_name, salary
FROM employees
WHERE first_name like '%am%';

-- 이름의 두번째 글자가 a 인 사원의 이름과 연봉을 출력하세요
SELECT first_name, salary
FROM employees
WHERE first_name like '_a%';

-- 이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
SELECT first_name, salary
FROM employees
WHERE first_name like '___a%';

-- 이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
SELECT first_name, salary
FROM employees
WHERE first_name like '__a_';
--is null / is not null
select  first_name,
        salary,
        commission_pct,
        salary*commission_pct
from employees
where salary between 13000 and 15000;

select  first_name,
        salary,
        commission_pct,
        salary*commission_pct
from employees
where commission_pct is null;

--커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
select  first_name,
        salary,
        commission_pct
from employees
where commission_pct is not null;

--담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
-- PPT 15 예제 
SELECT first_name, 
        salary,
        commission_pct,
        salary*commission_pct
FROM employees
where   commission_pct is null;

select  first_name,
        salary
from employees
where salary >= 10000;

--order by 절을 사용해 보기 좋게 정렬하기
select  first_name
from employees
order by salary asc;   --desc

select  first_name, 
        salary
from employees
where salary >=9000
order by salary asc;


--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
select  department_id,
        salary,
        first_name
from employees
order by department_id asc;

--급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
select  first_name,
        salary
from employees
where salary >=10000
order by salary desc;

--부서번호를　오름차순으로　정렬하고　부서번호가　같으면　급여가　높은　사람부터　
--부서　번호　급여　이름을　출력하세요
select  department_id,   
        salary,
        first_name
from employees
order by department_id asc, salary desc, first_name desc ;

-- 단일행 함수
--문자함수 - INITTAP(컬럼명)
-- 부서번호 100인 직원의 이메일 주소와 부서번호를 입력
SELECT email, 
        initap(email) "emai12", 
        department_id
FROM employees
where department_id = 100;

--문자함수 LOWER UPPER(컬럼명)
select first_name,
       upper(first_name) "upper",
       lower(first_name)lower
from employees
where department_id = 100;

--문자함수 -SUBSTR(컬럼명, 시작위치, 글자수)
select first_name,
       substr(first_name,1,4), 
       substr(first_name,-3,2)
from employees
where department_id = 100;

--문자함수 -LPAD(컬럼명, 자리수, '채울문자') / RPAD(컬럼명, 자리수, '채울문자')
select first_name,
       lpad(first_name, 10, '*'),
       rpad(first_name, 10, '*'),
       rpad(lpad(first_name, 10, '*'), 15, '*')
from employees;

--문자함수 -Replace(컬럼명, 문자1, 문자2)
select first_name,
       replace(first_name, 'a', '*'),
       substr(first_name,2,3),
       replace(first_name, substr(first_name, 2,3), '***' )
from employees
where department_id = 100;

select replace('abcdefg', 'bc', '*****')
from dual;

select substr('900214-1234234',8,1)
from dual;

--숫자함수 - ROUND(숫자, 출력을 원하는 자리수)
select round (123.353, 2) r2,
       round (123.556, 0) r0,
       round (123.456, -1) "r-1"
from dual;

--숫자함수 - TRUNC (숫자, 출력을 원하는 자리수)
select trunc (123.353, 2) r2,
       trunc (123.353, 2) r0,
       trunc (123.353, 1) "r-1"
from dual;

--날짜함수 - SYSDATE() 오늘날짜
select sysdate
from dual;

select months_between('22/05/12','22/04/12')
from employees
where department_id = 110;

--TO_CHAR(숫자, ‘출력모양’)  숫자형문자형으로 변환하기
select first_name,
       to_char(salary*12, '$099999')
from employees
where department_id = 110;

select to_char(9876, '99999'),
       to_char(9876, '099999'),
       to_char(9876, '$99999'),
       to_char(9876, '9999.00'),
       to_char(987654321, '999,999,999'),
       to_char(987654321, '999,999,999.999')
from dual;

--변환함수>TO_CHAR(날짜, ‘출력모양’)  날짜문자형으로 변환하기
select sysdate,
       to_char (sysdate,'YYYY-MM-DD'),
        to_char (sysdate,'YYYY.MM.DD HH24:MI:SS'),
       to_char (sysdate,'YYYY'),
       to_char (sysdate,'YY'),
       to_char (sysdate,'MM'),
       to_char (sysdate,'MONTH'),
       to_char (sysdate,'DD'),
       to_char (sysdate,'DAY'),
       to_char (sysdate,'DDTH'),
       to_char (sysdate,'HH24'),
       to_char (sysdate,'MI'),
       to_char (sysdate,'ss')
from dual;


select next_day(sysdate, 'FRIDAY') 
from dual; 


--수업 10시부터
--일반함수>NVL(컬럼명, null일때값)/NVL2(컬럼명, null아닐때값, null일때 값)
SELECT first_name,
       commission_pct,
       nvl(commission_pct, 0),
       nv12(commission_pct, 100, 0)
FROM employees;


/********그룹함수*********/
SELECT first_name,
        SUM(salary)
FROM employees;

--그룹함수 - count()
SELECT COUNT(*)
FROM  employees;

SELECT COUNT(*),
        COUNT(commission_pct),   --commission_pct 컬럼의 null 카운트에서 제외
        COUNT(manager_id) 
FROM  employees;

SELECT COUNT(*)
FROM  employees
where salary > 16000;

--그룹함수 - sum()
SELECT sum(salary)
FROM  employees;

--그룹함수 - avg()
SELECT avg(salary),     --급여가 null인 사람은 평균계산 제외
        avg(nvl(salary,0)),     --null인 값은 0으로 변경후 평균계산
        round(avg(nvl(salary,0))),      --반올림
        COUNT(*),
        sum(salary)
FROM  employees;

--그룹함수 - max() / min()
SELECT MAX(salary),
        MIN(salary),
        count(*)
FROM employees;

--GROUP BY 절
--절의 구성을 표현
SELECT first_name
FROM employees
where salary >16000
order by salary desc; 


SELECT department_id,
        avg(salary)     --department_id 부서별 평균
FROM employees      
group by department_id  --이 부분 없으면 전체 평균 구하는 식이 됨(그러나 오류는 남)
order by department_id asc;

--ORACLE 03 : PPT 10
SELECT department_id,
        job_id,
        avg(salary),    -- department_id 부서별 평균
        sum(salary),    -- department_id 부서별 합계
        count(salary)  -- department_id 부서별 카운트
FROM employees
group by department_id, job_id
order by department_id asc;


--예제 PPT11 :연봉(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 급여합계를 출력하세요
SELECT department_id,
       COUNT(*),
       sum(salary)
FROM employees
--where sum(salary)>= 20000       --where절에는 그룹함수 사용불가=> having 사용
group by department_id
having sum(salary)>=20000
and sum(salary) <= 100000
and department_id = 90;          --조건을 붙일 수 있음!
--and hire_date >= '04/01/01';    불가, having절에는 그룹함수와 Group by에 참여한 컬럼만 사용할 수 있다. 


--CASE ~ END 문 / DECODE()함수
SELECT employee_id,
        first_name,
        job_id,
        salary,
        --salary+salary*0.1 realSalary
        case 
            when job_id = 'AC_ACCOUNT' then salary+salary*0.1
            when job_id = 'SA_REP' then salary+salary*0.2
            when job_id = 'ST_CLERK' then salary+salary*0.3
       END realSalary
FROM employees;

--DECODE 문
SELECT employee_id,
        first_name,
        job_id,
        salary,
        decode(job_id, 'AC_ACCOUNT', salary+salary*0.1,
                        'SA_REP', salary+salary*0.2, 
                        'ST_CLERK', salary+salary*0.3,
                salary) bonus
from employees;

--PPT20 : 직원의 이름, 부서, 팀을 출력하세요
--팀은 코드로 결정하며 부서코드가 10~50 이면 ‘A-TEAM’
--60~100이면 ‘B-TEAM’  110~150이면 ‘C-TEAM’ 나머지는 ‘팀없음’ 으로 출력하세요.
SELECT first_name,
        department_id,
        case when department_id >=10 and department_id <=50 then 'A팀'
             when department_id >=60 and department_id <=100 then 'B팀'
             when department_id >=100 and department_id <=150 then 'C팀'
        else '팀없음'
        end team
FROM employees;


--JOIN
SELECT *
FROM employees, departments;

--join의 기본 (EQ join)
SELECT employee_id,
        first_name,
        salary,
        department_name,
        em.department_id "e_did", --출신을 명확하게 써야함 그냥 department_id 이렇게 쓰면 오류남.
        de.department_id "d_did"
FROM employees em, departments de
where em.employee_id = de.department_id;

--PPT26
SELECT  em.first_name,
        de.department_name,
        jo.job_title,
        em.department_id,
        de.department_id,
        em.job_id,
        jo.job_id
FROM employees em, departments de, jobs jo
where em.department_id = de.department_id
and em.job_id =  jo.job_id;
---------------------------------------------------------- 
SELECT  em.first_name,
        de.department_name,
        jo.job_title,
        em.department_id,
        de.department_id,
        em.job_id,
        jo.job_id
FROM employees em, departments de, jobs jo
where em.department_id = de.department_id
and em.job_id =  jo.job_id;

