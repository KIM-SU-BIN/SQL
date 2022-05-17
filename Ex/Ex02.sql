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
