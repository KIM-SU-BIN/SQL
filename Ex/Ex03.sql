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

--<self join> 매니저의 이름과 전화번호
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
