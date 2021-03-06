--Practice2 집계(통계) SQL 문제
--1. 매니저가 있는 직원은 몇 명입니까? 아래의 결과가 나오도록 쿼리문을 작성하세요
SELECT count(*)
FROM employees
order by manager_id;

--2.직원중에 최고임금(salary)과  최저임금을 “최고임금, “최저임금”프로젝션 타이틀로 함께 출력해 보세요. 
--두 임금의 차이는 얼마인가요?  “최고임금 – 최저임금”이란 타이틀로 함께 출력해 보세요.
SELECT  MIN(salary) "최저임금", 
        MAX(salary) "최고임금", 
        MAX(salary) -  MIN(salary) "최고임금 – 최저임금"
FROM employees;

--3.마지막으로 신입사원이 들어온 날은 언제 입니까? 다음 형식으로 출력해주세요. 예) 2014년 07월 10일
--SELECT replace(hire_date,'/','YYYY년MM월DD일')
SELECT  max(to_char(hire_date, 'YYYY"년"MM"월"DD"일"'))
FROM employees;

--4.부서별로 평균임금, 최고임금, 최저임금을 부서아이디(department_id)와 함께 출력합니다.
--정렬순서는 부서번호(department_id) 내림차순입니다.
SELECT  AVG(salary), 
        max(salary),
        min(salary),
        department_id
FROM employees
group by department_id
order by department_id asc;

--5.업무(job_id)별로 평균임금, 최고임금, 최저임금을 업무아이디(job_id)와 함께 출력하고 
--정렬순서는 최저임금 내림차순, 평균임금(소수점 반올림), 오름차순 순입니다.
--(정렬순서는 최소임금 2500 구간일때 확인해볼 것)
SELECT  job_id,
         AVG(salary),
         max(salary),
         NULLIF(min(salary),2500)  --2500인 경우 반환
FROM employees
group by job_id
order by  min(salary)desc,
          round(AVG(salary),2)asc;
          
--6.가장 오래 근속한 직원의 입사일은 언제인가요? 다음 형식으로 출력해주세요. 예) 2001-01-13 토요일 
select min(to_char(hire_date,'YYYY-MM-DD day'))
from employees;

--7.평균임금과 최저임금의 차이가 2000 미만인 부서(department_id), 평균임금, 최저임금 
--그리고 (평균임금 – 최저임금)를 (평균임금 – 최저임금)의 내림차순으로 정렬해서 출력하세요.
SELECT  department_id,
        AVG(salary), 
        min(salary),
        AVG(salary) - min(salary)
FROM employees
Group by department_id
having AVG(salary) - min(salary) < 2000
order by AVG(salary) - min(salary) desc; 
--헤빙으로 2000미만 오더바이로 내림차순

--8.업무(JOBS)별로 최고임금과 최저임금의 차이를 출력해보세요.
--차이를 확인할 수 있도록 내림차순으로 정렬하세요. 
SELECT job_title,
        max_salary - min_salary "최고임금 - 최저임금"
FROM jobs
order by max_salary - min_salary desc;

--9.2005년 이후 입사자중 관리자별로 평균급여 최소급여 최대급여를 알아보려고 한다.
--출력은 관리자별로 평균급여가 5000이상 중에 평균급여 최소급여 최대급여를 출력합니다.
--평균급여의 내림차순으로 정렬하고 평균급여는 소수점 첫째짜리에서 반올림 하여 출력합니다.
SELECT  hire_date,
        round (AVG(salary),0),
        MIN(salary),
        MAX(salary)
FROM employees
GROUP BY hire_date, manager_id
HAVING hire_date >= '05/01/01'
and AVG(salary) >= 5000
ORDER BY AVG(salary) desc;

--10.아래회사는 보너스 지급을 위해 직원을 입사일 기준으로 나눌려고 합니다. 
-- 입사일이 02/12/31일 이전이면 '창립맴버, 03년은 '03년입사’, 04년은 ‘04년입사’ 
--이후입사자는 ‘상장이후입사’ optDate 컬럼의 데이터로 출력하세요.
--정렬은 입사일로 오름차순으로 정렬합니다.
SELECT  hire_date,
        CASE when hire_date < '02/12/31' then '창립멤버'
        when hire_date < '03/12/31' then '03년 입사'
        when hire_date < '04/12/31' then '04년 입사'
        else '상장이후입사'
        end optDate
FROM employees
GROUP BY hire_date
ORDER by hire_date asc;
--case문 ',' 없음 주의!!