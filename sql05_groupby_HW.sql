-- 아래의 모든 문제에서 소수점은 반올림해서 2자리까지 표시.
-- Ex. 부서별 급여의 평균, 표준편차를 출력. 부서번호 오름차순 정렬.
select deptno, 
round(avg(sal),2) as "average", 
round(stddev(sal),2) as "stddev"
from emp
group by deptno
order by deptno;

-- Ex. 직무별 직원수, 급여의 최댓값, 최솟값, 평균 검색.
-- 직무 오름차순 정렬
select job, count(empno)  as "staff", 
round(max(sal),2) as "MAX", 
round(min(sal),2) as "MIN", 
round(avg(sal),2) as "average"
from emp
group by job
order by job;

-- Ex. 부서별, 직무별 부서번호, 직무, 직원수, 급여 평균 검색
-- 정렬 순서는 (1) 부서 번호 (2) 직책 오름차순
select deptno, job, count(empno) as "staff",round(avg(sal),2) as "average"
from emp
group by deptno,job
order by deptno, job;

-- Ex. 입사연도별 사원수 검색. (힌트) to_char(날짜, 포맷) 이용.
select to_char(hiredate,'YYYY') as "YEAR",count(empno)
from emp
group by to_char(hiredate,'YYYY')
order by to_char(hiredate,'YYYY'); 
