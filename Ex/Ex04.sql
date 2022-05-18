
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

----------------------------------------------------------------------------
/*<5월 18일 오전> PPT04
[예제] 급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.
1. 급여순으로 정렬 */
SELECT  employee_id, 
        first_name, 
        salary
FROM employees
ORDER BY salary desc;

--2.1~5등만 출력 => order by 사용하면 ﻿rownum 정렬 흐뜨러짐(rownum과 order by 같이 사용불가)
SELECT  ROWNUM,
        employee_id, 
        first_name, 
        salary
FROM employees
where ROWNUM >= 1
and ROWNUM <=5 ;

--최종
SELECT  ROWNUM,
        ot.employee_id,
        ot.first_name,
        ot.salary               --컬럼 추가하려면 from에 있는 selec에 추가된 컬럼이 있어야 사용할 수 있음!
FROM (SELECT  employee_id, 
              first_name, 
              salary
      FROM employees
      ORDER BY salary desc) ot 
where ROWNUM >= 1
and ROWNUM <= 5;

-- 3 ~ 5등까지 : 데이터가 없어서 구할 수 없는 것 / 현재 식은 시작이 1이 아니면 구할 수 없음!
SELECT  ROWNUM rn,
        ot.employee_id,
        ot.first_name,
        ot.salary               --컬럼 추가하려면 from에 있는 selec에 추가된 컬럼이 있어야 사용할 수 있음!
FROM (SELECT  employee_id, 
              first_name, 
              salary
      FROM employees
      ORDER BY salary desc) ot 
where ROWNUM >= 3
and ROWNUM <= 5;

--3 ~ 5 최종
SELECT *
FROM (SELECT  ROWNUM rn,
        ot.employee_id,
        ot.first_name,
        ot.salary               --컬럼 추가하려면 from에 있는 selec에 추가된 컬럼이 있어야 사용할 수 있음!
      FROM (SELECT  employee_id, 
                    first_name, 
                    salary
            FROM employees
            ORDER BY salary desc) ot 
            ) ort
where rn >= 2
and rn< 5;

--최종
-->(1)정렬하고 (2)rownum이 있는 테이블을 사용하고 (3)where절을 쓴다
select  ort.rn,
        ort.first_name,
        ort.salary
from (select  rownum rn,
              ot.employee_id,
              ot.first_name,
              ot.salary
      from (select  employee_id,
                    first_name,
                    salary
            from employees
            order by salary desc) ot   --(1)
      )ort  --(2)
where rn >= 2
and rn<=5;  --(3)

----------------------------------------------------------------------------
/*<5월 18일 오전> PPT04
[예제] 급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.
1. 급여순으로 정렬 */
SELECT  employee_id, 
        first_name, 
        salary
FROM employees
ORDER BY salary desc;

--2.1~5등만 출력 => order by 사용하면 ﻿rownum 정렬 흐뜨러짐(rownum과 order by 같이 사용불가)
SELECT  ROWNUM,
        employee_id, 
        first_name, 
        salary
FROM employees
where ROWNUM >= 1
and ROWNUM <=5 ;

--최종
SELECT  ROWNUM,
        ot.employee_id,
        ot.first_name,
        ot.salary               --컬럼 추가하려면 from에 있는 selec에 추가된 컬럼이 있어야 사용할 수 있음!
FROM (SELECT  employee_id, 
              first_name, 
              salary
      FROM employees
      ORDER BY salary desc) ot 
where ROWNUM >= 1
and ROWNUM <= 5;

-- 3 ~ 5등까지 : 데이터가 없어서 구할 수 없는 것 / 현재 식은 시작이 1이 아니면 구할 수 없음!
SELECT  ROWNUM rn,
        ot.employee_id,
        ot.first_name,
        ot.salary               --컬럼 추가하려면 from에 있는 selec에 추가된 컬럼이 있어야 사용할 수 있음!
FROM (SELECT  employee_id, 
              first_name, 
              salary
      FROM employees
      ORDER BY salary desc) ot 
where ROWNUM >= 3
and ROWNUM <= 5;

--3 ~ 5 최종
SELECT *
FROM (SELECT  ROWNUM rn,
        ot.employee_id,
        ot.first_name,
        ot.salary               --컬럼 추가하려면 from에 있는 selec에 추가된 컬럼이 있어야 사용할 수 있음!
      FROM (SELECT  employee_id, 
                    first_name, 
                    salary
            FROM employees
            ORDER BY salary desc) ot 
            ) ort
where rn >= 2
and rn< 5;

--최종
-->(1)정렬하고 (2)rownum이 있는 테이블을 사용하고 (3)where절을 쓴다
select  ort.rn,
        ort.first_name,
        ort.salary
from (select  rownum rn,
              ot.employee_id,
              ot.first_name,
              ot.salary
      from (select  employee_id,
                    first_name,
                    salary
            from employees
            order by salary desc) ot   --(1)
      )ort  --(2)
where rn >= 2
and rn<=5;  --(3)

------------------------------------------------------------------------

--[예제] 07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은? 
--07년 입사자
SELECT  first_name,
        hire_date,
        salary
FROM employees
WHERE hire_date >= '07/01/01'
and hire_date <= '07/12/31'
ORDER BY salary desc;

--최종
SELECT  ro.rn,
        ro.first_name,
        ro.salary
from (SELECT ROWNUM rn,
            ye.first_name,
            ye.hire_date,
            ye.salary
        FROM (SELECT  first_name,
                      hire_date,
                      salary
                FROM employees
                WHERE hire_date >= '07/01/01'       --'07%'로 사용 가능하나 오류가 있을 수는 있음
                and hire_date <= '07/12/31'
                ORDER BY salary desc) ye
        )ro
where rn >= 3
and rn <= 7;
