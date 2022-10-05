-- HR 계정의 테이블을 사용한 GROUP BY, JOIN, SUB QUERY 연습
-- 1. 직원의 last_name과 부서 이름을 검색.
select e.last_name, d.department_name
from employees e
    join departments d on e.department_id = d.department_id
order by e.last_name;

-- 2. 직원의 last_name과 부서 이름을 검색. 부서 번호가 없는 직원도 출력.
select e.last_name,e.department_id, d.department_name
from employees e
    left outer join departments d on e.department_id = d.department_id;

-- 3. 직원의 last_name과 직무(job title)을 검색.
select last_name, job_title
from employees e
    join jobs j on e.job_id = j.job_id
order by last_name;

-- 4. 직원의 last_name과 직원이 근무하는 도시 이름(city)를 검색.
select last_name, city
from employees e
    join departments d on e.department_id = d.department_id
    join locations l on l.location_id = d.location_id
order by last_name;

-- 5. 직원의 last_name과 직원이 근무하는 도시 이름(city)를 검색. 근무 도시를 알 수 없는 직원도 출력.
select last_name, city
from employees e
    left join departments d on e.department_id = d.department_id
    left join locations l on l.location_id = d.location_id
order by last_name;

-- 6. 2008년에 입사한 직원들의 last_name을 검색.
select last_name,hire_date
from employees
where to_char(hire_date,'YYYY') = '2008';
-- 7. 2008년에 입사한 직원들의 부서 이름과 부서별 인원수 검색.
select d.department_name,count(*)
from employees e
    join departments d on e.department_id = d.department_id
where to_char(hire_date,'YYYY') = '2008'
group by d.department_name;

-- 8. 2008년에 입사한 직원들의 부서 이름과 부서별 인원수 검색. 
--    단, 부서별 인원수가 5명 이상인 경우만 출력.
select d.department_name,count(*)
from employees e
    join departments d on e.department_id = d.department_id
where to_char(hire_date,'YYYY') = '2008'
group by d.department_name
having count(d.department_name) >= 5;

-- 9. 부서번호, 부서별 급여 평균을 검색. 소숫점 한자리까지 반올림 출력.
select d.department_id, d.department_name, round(avg(e.salary),1) as "급여 평균",count(*)
from employees e
    join departments d on e.department_id = d.department_id
group by d.department_id, d.department_name;

-- 10. 부서별 급여 평균이 최대인 부서의 부서번호, 급여 평균을 검색.
-- 서브쿼리 활용
select d.department_id, round(avg(e.salary),1)
from employees e
    join departments d on e.department_id = d.department_id
group by d.department_id
having d.department_id = 90;


-- 11. 사번, 직원이름, 국가이름, 급여 검색.
select e.employee_id, e.first_name || ' ' || e.last_name as "name", c.country_name, e.salary
from employees e 
    join departments d on e.department_id = d.department_id
    join locations l on d.location_id = l.location_id
    join countries c on l.country_id = c.country_id;

-- 12. 국가이름, 국가별 급여 합계 검색
select c.country_name, sum(e.salary)
from employees e 
    join departments d on e.department_id = d.department_id
    join locations l on d.location_id = l.location_id
    join countries c on l.country_id = c.country_id
group by c.country_name;

-- 13. 사번, 직원이름, 직책이름, 급여를 검색.
select e.employee_id, e.first_name || ' ' || e.last_name as "name", d.department_name, e.salary
from employees e
    join departments d on e.department_id = d.department_id;

-- 14. 직책이름, 직책별 급여 평균, 최솟값, 최댓값 검색.
select department_name, round(avg(salary),1), max(salary), min(salary)
from employees e
    join departments d on e.department_id = d.department_id
group by department_name;

-- 15. 국가이름, 직책이름, 국가별 직책별 급여 평균 검색.
select c.country_name, d.department_name, round(avg(e.salary),1)
from employees e
    join departments d on e.department_id = d.department_id
    join locations l on d.location_id = l.location_id
    join countries c on l.country_id = c.country_id
group by c.country_name, d.department_name;

-- 16. 국가이름, 직책이름, 국가별 직책별 급여 합계을 출력.
--     미국에서, 국가별 직책별 급여 합계가 50,000 이상인 레코드만 출력.

-- 국가별 직책별 급여 합계를 출력한 코드
select c.country_name, d.department_name, round(sum(e.salary),1) as "급여 합계"
from employees e
    join departments d on e.department_id = d.department_id
    join locations l on d.location_id = l.location_id
    join countries c on l.country_id = c.country_id
group by c.country_name, d.department_name;


-- 국가별 직책별 급여 합계가 50,000 이상인 레코드만 출력
select c.country_name, d.department_name, round(sum(e.salary),1) as "급여 합계"
from employees e
    join departments d on e.department_id = d.department_id
    join locations l on d.location_id = l.location_id
    join countries c on l.country_id = c.country_id
group by c.country_name, d.department_name
having sum(e.salary) >= 50000;
