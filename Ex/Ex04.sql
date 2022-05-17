
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