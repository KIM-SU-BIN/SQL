--1.평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시오.
--평균 급여구하기
SELECT avg(salary)
FROM employees;

--최종
SELECT COUNT(employee_id)
FROM employees
where salary < any(SELECT avg(salary)
                   FROM employees);
                
/*2. 평균급여 이상, 최대급여 이하의 월급을 받는 사원의 직원번호(employee_id), 이름(first_name), 급여(salary), 
평균급여, 최대급여를 급여의 오름차순으로 정렬하여 출력하세요(51건)*/ --==> 조건절은 안되고 테이블로만 되나...?
--평균급여 이상
SELECT *
FROM employees
where salary >= any(SELECT avg(salary)
                    FROM employees) ;

--최대급여 이하
SELECT *
FROM employees
where salary <= any(SELECT max(salary)
                    FROM employees) ;
                    
--최종
SELECT employee_id, first_name, salary
FROM employees
where salary >= ALL(SELECT avg(salary) avg
                    FROM employees) 
and salary <= ALL(SELECT max(salary) max
                    FROM employees) 
ORDER BY salary asc;

/*3.직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주(state_province), 
나라아이디(country_id) 를 출력하세요 (1건)*/
-- 직원중 Steven(first_name) king(last_name) 찾기
SELECT *
FROM employees
where first_name = 'Steven'
and last_name = 'King';

--소속된 부서의 주소
SELECT *
FROM departments
where department_id = 90;

SELECT *
FROM locations
where location_id = 1700;

--최종 
SELECT * 
FROM locations
where location_id in (SELECT location_id
                        FROM departments
                        where department_id in (SELECT department_id 
                                                FROM employees
                                                where first_name = 'Steven'
                                                and last_name = 'King'));

/*4.job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 급여의 내림차순으로 출력하세요  -ANY연산자 사용 (74건)*/
--job_id 'ST_MAN' 인 직원의 아이디와 급여
SELECT job_id, salary
FROM employees
where job_id = 'ST_MAN';

--최종
SELECT employee_id, first_name, salary
FROM employees 
where salary < any (SELECT salary
                    FROM employees
                    where job_id = 'ST_MAN')
order by salary desc;

/*5.각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name)과 급여(salary) 부서번호(department_id)를 조회하세요 
단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다.  
조건절비교, 테이블조인 2가지 방법으로 작성하세요 (11건)*/

--부서별로 최고 급여 받는 직원
SELECT MAX(salary),department_id
FROM employees
GROUP BY department_id;

--최종< 조건절 비교 >
SELECT  employee_id, 
        first_name, 
        salary, 
        department_id
FROM employees
where (salary, department_id) in (SELECT MAX(salary), 
                                         department_id
                                  FROM employees
                                  GROUP BY department_id) 
ORDER BY salary desc;

--최종< 테이블조인 >
SELECT  employee_id, 
        first_name, 
        e.salary, 
        e.department_id
FROM employees e, (SELECT MAX(salary) salary, 
                          department_id
                   FROM employees
                   GROUP BY department_id)s 
where e.department_id = s.department_id
and e.salary = s.salary
ORDER BY salary desc;

/*6.각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 (19건)*/
--업무별 그룹
SELECT job_title 
FROM jobs
group by job_title;

--업무별 급여의 총합 (title이 필요함)
SELECT sum(salary)
FROM employees 
group by job_id;

--최종
SELECT  jo.job_title 업무명, 
        em.salary 연봉
FROM employees em, jobs jo
where salary in (SELECT sum(salary)
                    FROM employees
                    group by job_id)                  
order by em.salary desc;


/*7.자신의 부서 평균 급여보다 급여(salary)이 많은 직원의 직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회하세요 (38건)*/
--부서별 평균급여
SELECT avg(salary)
FROM employees, departments
group by department_name;     

--연봉
SELECT salary*12
FROM employees;

--최종
SELECT employee_id, first_name, e.salary
FROM employees e, (SELECT avg(salary) salary
                        ,department_id
                   FROM employees
                   group by department_id)s
where e.salary > s.salary
and e.department_id = s.department_id;
                         
/*8.직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력하세요*/
SELECT  ro.rn,
        ro.employee_id,
        ro.first_name,
        ro.salary,
        ro.hire_date
from (SELECT  rownum rn, 
                hi.employee_id, 
                hi.first_name, 
                hi.salary, 
                hi.hire_date
        FROM (select employee_id,           --입사일 순서대로
                        first_name, 
                        salary, 
                        hire_date
              from employees 
              order by hire_date asc) hi
              )ro
where rn >= 11 
and rn <= 15;