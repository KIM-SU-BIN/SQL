/* <혼합 SQL 문제>
문제1.담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.(45건) */

SELECT first_name,
        manager_id,
        commission_pct,
        salary
FROM employees
where commission_pct is null 
and manager_id is not null
and salary > 3000;


/*문제2.각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 급여(salary), 
입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하세요 
-조건절비교 방법으로 작성하세요
-급여의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.(11건)*/

--부서별 최고 급여 
SELECT MAX(salary),
        department_id
FROM employees
group by department_id;

--최종
SELECT employee_id 직원번호,
        first_name 이름,
        salary 급여,
        to_char (hire_date, 'YYYY-MM-DD day') 입사일,
        replace (phone_number, '.' , '-' )전화번호 ,
        department_id 부서번호
FROM employees
where (salary, department_id) in (SELECT MAX(salary), 
                                         						 department_id
				                                   FROM employees
				                                   GROUP BY department_id) 
ORDER BY salary desc;

                               
/*문제3 매니저별 담당직원들의 평균급여 최소급여 최대급여를 알아보려고 한다.
-통계대상(직원)은 2005년 이후(2005년 1월 1일 ~ 현재)의 입사자 입니다.
-매니저별 평균급여가 5000이상만 출력합니다. 0
-매니저별 평균급여의 내림차순으로 출력합니다. 0
-매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다. 0 
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별최대급여 입니다.(9건)*/ 

--매니저별 평균급여 최소급여 최대급여 5000이상 내림차순 반올림
SELECT manager_id, 
	        max(salary),
	        min(salary),
	        round(avg(salary),0)
FROM employees
group by manager_id
having avg(salary) >= 5000;

--최종 => 보류
SELECT  m.manager_id "매니저 아이디",
        first_name "매니저 이름",
        ma "최대급여",
        mi "최소급여",
        av "평균급여"
FROM employees e,(SELECT manager_id, 
					                         max(salary) ma,
					                         min(salary) mi,
					                         round(avg(salary),0) av
			                    FROM employees
			                    group by manager_id
			                    having avg(salary) >= 5000 --출력조건이라서 안에 말고 밖에 써야하는걸까? 왜 having은 안될까...?
			                    order by av desc) m				--having은 group by와 짝꿍
where e.manager_id = m.manager_id
and hire_date >= '05/01/01';

--정답
SELECT  e.manager_id "매니저 아이디",
        e.first_name "매니저 이름",
        m.ma "최대급여",
        m.mi "최소급여",
        m.av "평균급여"
FROM employees e,(SELECT manager_id, 
					                         max(salary) ma,
					                         min(salary) mi,
					                         round(avg(salary),0) av
			                    FROM employees
			                    where hire_date >= '05/01/01'
			                    group by manager_id) m		
where e.employee_id = m.manager_id
and m.av >= 5000
order by m.av desc;


/*문제4.각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.(106명)*/
SELECT em.employee_id 사번, 
	        em.first_name 이름,
	        de.department_name 부서명,
	        ma.first_name 매니저이름
FROM employees em, employees ma, departments de
where em.manager_id = ma.employee_id
and de.department_id= ma.department_id;


/*문제5번. 2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요*/
--기본 틀
SELECT employee_id,
		        first_name,
		        department_name,
		        salary,
		        hire_date
FROM employees em, departments de
where hire_date >= '05/01/01'
order by hire_date;

--1차 rownum
SELECT ROWNUM rn,
		        fr.employee_id,
		        fr.first_name,
		        fr.department_name,
		        fr.salary,
		        fr.hire_date
FROM (SELECT employee_id,
				        first_name,
				        department_name,
				        salary,
				        hire_date
		    FROM employees em, departments de
		    where hire_date >= '05/01/01'
		    order by hire_date) fr;

--최종 rownum
SELECT se.rn,
        se.employee_id,
        se.first_name,
        se.department_name,
        se.salary,
        se.hire_date
FROM (SELECT ROWNUM rn,
			            fr.employee_id,
			            fr.first_name,
			            fr.department_name,
			            fr.salary,
			            fr.hire_date
         FROM (SELECT employee_id,
				                    first_name,
				                    department_name,
				                    salary,
				                    hire_date
	                FROM employees em, departments de
	                where hire_date >= '05/01/01'
	                order by hire_date) fr
	            )se
where rn >=11
and rn <= 20;


/*문제6.가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름(department_name)은?*/
--가장 늦은 입사날짜
SELECT max(hire_date)
FROM employees;

--최종
SELECT first_name ||''|| last_name 이름,
        salary 급여,
        department_name 부서명,
        em.hire_date
FROM employees em, departments de
where hire_date in (SELECT max(hire_date) 
                    FROM employees)
and em.department_id = de.department_id; --중복제거


/*문제7.평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 
성(last_name)과  업무(job_title), 연봉(salary)을 조회하시오.*/

SELECT salary
FROM employees, departments 
where max(salary) <= avg(salary);



/*문제8. 평균 급여(salary)가 가장 높은 부서는? */
--부서별 평균
SELECT department_id, avg(salary)
FROM employees
group by department_id;

--평균이 큰 부서
SELECT MAX(ms)
FROM (SELECT department_id, 
             avg(salary) ms
        FROM employees
        group by department_id);
        
 --부서별 평균 + 평균이 큰 부서    
SELECT department_id
FROM employees
GROUP BY department_id
having avg(salary) in (SELECT MAX(ms)
                        FROM (SELECT department_id, 
                                     avg(salary) ms
                                FROM employees
                                group by department_id)) ;
        
--최종
SELECT department_name
FROM departments
where department_id in (SELECT department_id
                        FROM employees
                        GROUP BY department_id
                        having avg(salary) in (SELECT MAX(ms)
                                                FROM (SELECT department_id, 
                                                             avg(salary) ms
                                                        FROM employees
                                                        group by department_id)) 
                                                        );




--문제9.평균 급여(salary)가 가장 높은 지역은? 
--지역명 출력
select region_name
from employees e, departments d, locations l, countries c, regions r
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id = r.region_id;


----------------------------------
//최종
select  region_name
from    regions r, (select region_id, salary
                    from (select region_id, avg(salary) salary
                         from (select r.region_id, region_name, salary
                                from  employees e, departments d, locations l, countries c, regions r
                                where e.department_id = d.department_id
                                and	  d.location_id = l.location_id
                                and	  l.country_id = c.country_id
                                and	  c.region_id = r.region_id )
                         group by region_id) ) s     			--FROM 끝
where	r.region_id = s.region_id                   			--중복제거
and		salary in	(select	max(salary)              			--내부조인 IN
					 from (select region_id, avg(salary) salary
						 	 from (select	r.region_id, salary
									from	employees e, departments d, locations l, countries c, regions r
									where	e.department_id = d.department_id
									and		d.location_id = l.location_id
									and		l.country_id = c.country_id
									and		c.region_id = r.region_id )
							group by region_id) );

----------------------------------
--범준ver
select re.region_name
from employees em, departments de, locations lo, countries co, regions re
where em.department_id = de.department_id       --중복제거
and de.location_id = lo.location_id
and lo.country_id = co.country_id
and co.region_id = re.region_id
group by re.region_name                          --지역별 그룹화
having avg(salary) = (select max(avg(salary))                              --지역별 평균 급여중 가장 큰 값
                        from employees em, departments de, locations lo, countries co, regions re
                        where em.department_id = de.department_id          --중복제거
                        and de.location_id = lo.location_id
                        and lo.country_id = co.country_id
                        and co.region_id = re.region_id
                        group by re.region_name); 							


                                                   
--문제10.평균 급여(salary)가 가장 높은 업무는?                
--업무별 평균 급여
SELECT max(AVG(salary))
FROM employees em, jobs jo
WHERE em.job_id = jo.job_id
GROUP BY jo.job_title;

--최종
SELECT job_title
FROM jobs jo, employees em
where em.job_id = jo.job_id
GROUP BY jo.job_title
having avg(salary) = (select max(avg(salary))
                        from employees em, jobs jo
                        where em.job_id = jo.job_id
                        group by jo.job_title);
