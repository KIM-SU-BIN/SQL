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

-----------------------------------------------------------
--<5월 16일 수업 PPT03>
--< EQ join > : null값은 포함하지 않는다.
SELECT  e.first_name,
        e.department_id,
        d.department_name,
        d.department_id
FROM employees e, departments d
where e.department_id = d.department_id;

--위 EQ join과 아래 left join 값 동일함!

--< left outer join > : null값 포함
SELECT  e.first_name,
        e.department_id,
        d.department_name,
        d.department_id
FROM employees e left outer join departments d
on e.department_id = d.department_id;

--<오라클 사용법> 107개
SELECT  e.first_name,
        e.department_id,
        d.department_name,
        d.department_id
FROM employees e, departments d
where e.department_id = d.department_id(+);


--< right outer join > : null값 포함
SELECT  e.first_name,
        e.department_id,
        d.department_name,
        d.department_id
FROM employees e right outer join departments d
on e.department_id = d.department_id;

--오라클 사용법 / ppt 참고
SELECT  e.first_name,
        e.department_id,
        d.department_name,
        d.department_id
FROM employees e, departments d
where e.department_id(+) = d.department_id;

--<full outer join> 양쪽 모두 선택
SELECT  e.first_name,
        e.department_id, 
        d.department_name, 
        d.department_id
FROM employees e full outer join departments d
on e.department_id = d.department_id;

--<self join> ==>> 매우 중요
SELECT *
FROM employees e1, employees e2
where e1.manager_id = e2.employee_id;

--<self join> 매니져의 이름과 전화번호
SELECT e.employee_id,
        e.first_name,
        e.salary,
        e.phone_number,
        e.manager_id,
        m.employee_id,
        m.first_name,
        m.phone_number
FROM employees e,employees m
where e.manager_id = m.employee_id;

-----------------------------------------------------------

--<05/16 PPT04 start>
--Q. ‘Den’ 보다 급여를 많은 사람의 이름과 급여는?
--1번째, Den 급여 찾기
SELECT first_name,
        salary
FROM employees
where first_name = 'Den'; --11000

--2번째, 11000보다 급여 많은 사람의 이름과 금액
SELECT first_name,
        salary
FROM employees
where salary >= 11000
order by salary desc;

-- 최종 공식 (1번 + 2번)
SELECT first_name,
        salary
FROM employees
where salary >= (SELECT first_name,
                 salary
                 FROM employees
                 where first_name = 'Den')
order by salary desc;



--Q. 급여를 가장 적게 받는 사람의 이름,급여,사원번호는?
--1번째, 가장 적게 받는 사람
SELECT min(salary)
FROM employees;

--2번째, 가장 적은 금액의 사람 정보 구하기
SELECT  first_name,
        salary,
        employee_id
FROM employees
where salary <= 2100;

--최종
SELECT  first_name,
        salary,
        employee_id
FROM employees
where salary <= (SELECT min(salary)
                FROM employees);
                


--평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요.
--1번째, 평균 급여 구하기
SELECT avg(salary)
FROM employees;

--2번째, 평균 급여보다 적게 받는 사람 정보
SELECT first_name,
        salary
FROM employees
where salary <= 6461.83177570;

--최종
SELECT first_name,
        salary
FROM employees
where salary <= (SELECT avg(salary)
                 FROM employees);
                 
/* <다중행> 
Q. 부서번호가 110인 직원의 급여와 같은 모든 직원의 사번, 이름, 급여를 출력하세요*/
--110 12000
--110 2700
SELECT *
from employees
where department_id = 110;

--수동으로 수한 것 (값을 입력했기 때문에)
SELECT employee_id,
        first_name,
        salary
from employees
where salary = 12008
or salary = 8300;

--자동으로 구하기 
SELECT employee_id,
        first_name,
        salary
FROM employees
where salary in (SELECT salary
                 from employees
                 where department_id = 110);
                 
---------------------------------------------------------------
--<5월 17일 수업>                                
--(복습)부서번호가 110인 직원의 급여와 같은 모든 직원의 사번, 이름, 급여를 출력하세요
SELECT *
FROM employees
where department_id = 110;

SELECT employee_id, salary, first_name
FROM employees
where salary in (SELECT salary
                FROM employees
                where department_id = 110);
--where salary = 8300 or salary = 12008식과 동일함!

--Q. 각 부서별로 최고급여를 받는 사원을 출력하세요.
-- 1.부서별로 최고 급여받는 사원 정보
SELECT  department_id,
        MAX(salary)
FROM employees
GROUP BY department_id;

--2. 이름을 나타내려면?
select department_id, employee_id, first_name, salary
from employees
where (department_id, salary) in (select 30, 11000
                                  from employees);
/*where의 쿼리문에 조건 하나 쓸 경우에는 select/from문 안 써도 되지만,
지금처럼 조건 두 개 이상 사용하면 select/from문 사용해야함*/

--최종
select department_id, employee_id, first_name, salary
from employees
where (department_id, salary) in (select department_id, max(salary)
                                  from employees
                                  group by department_id);

/*ANY 연산자 (=or)             
    Q. 부서번호가 110인 직원의 급여 보다 큰 모든 직원의 사번, 이름, 급여를 출력하세요.(or연산--> 8300보다 큰)
    1. 부서번호가 110인 직원 구하기*/
SELECT department_id, first_name, salary
FROM employees
where department_id = 110;          

--2. 12008, 8300보다 큰 급여의 직원구하기
SELECT department_id, first_name, salary
FROM employees
where salary > 12008
or salary >8300;

--or를 대표하는 any로 변경

--최종 (쿼리 사용)
SELECT department_id, first_name, salary
FROM employees
where salary > any (SELECT salary
                    FROM employees              
                    where department_id = 110);
                    
/*ALL (=and)
ALL / ANY 비교
    Q. 부서번호가 110인 직원의 급여 보다 큰 모든 직원의 사번, 이름, 급여를 출력하세요.(and연산--> 12008보다 큰)
    1.110의 부서번호 직원의 급여 구하기 ==>> 12008, 8300
    2. 최종*/
SELECT first_name, salary
FROM employees
WHERE salary > all (SELECT salary
                    FROM employees
                    where department_id > 110);
                    
--부서번호 30번 사원 급여 중 가장 낮은 값(950)보다 높은 급여를 받는 사원들의 이름, 급여를 출력해보자.
--1. 부서번호가 30, 급여 오름차순 ::: 인터넷문제
SELECT first_name, department_id, employee_id, salary
FROM employees
where department_id = 30
order by salary asc;

-------------------------------------------------------------------------

--(PPT10)각 부서별로 최고급여를 받는 사원을 출력하세요
--group by 사용할 경우 select에 올 수 있는 애들은 한정되어있음 (관련있는 애들만 올 수 있다.)
SELECT first_name,salary, department_id
FROM employees
where (department_id, salary) in (select department_id,
                              MAX(salary)
                              from employees 
                              group by department_id);
                              
-- 위의 문제 테이블로 구하기         
SELECT  e.first_name,
        e.salary,
        e.department_id,
        s.department_id,
        s.maxsalary
FROM employees e ,(SELECT MAX(salary) maxSalary, 
                         department_id  
                  FROM employees
                  group by department_id)s
where e.department_id = s.department_id             -->> 중복값 제거
and e.salary = s.maxSalary;                            

                 


