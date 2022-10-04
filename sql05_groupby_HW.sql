-- 아래의 모든 문제에서 소수점은 반올림해서 2자리까지 표시.
-- Ex. 부서별 급여의 평균, 표준편차를 출력. 부서번호 오름차순 정렬.
select deptno, 
round(avg(sal),2) as "AVG_SAL", 
round(stddev(sal),2) as "STD_SAL"
from emp
group by deptno
order by deptno;

-- Ex. 직무별 직원수, 급여의 최댓값, 최솟값, 평균 검색.
-- 직무 오름차순 정렬
select job, 
count(job)  as "COUNT", 
round(max(sal),2) as "MAX_SAL", 
round(min(sal),2) as "MIN_SAL", 
round(avg(sal),2) as "AVG_SAL"
from emp
group by job
order by job;

-- Ex. 부서별, 직무별 부서번호, 직무, 직원수, 급여 평균 검색
-- 정렬 순서는 (1) 부서 번호 (2) 직책 오름차순
select deptno,job,
count(empno) as "staff",
round(avg(sal),2) as "average"
from emp
group by deptno,job
order by deptno, job;

-- Ex. 입사연도별 사원수 검색. (힌트) to_char(날짜, 포맷) 이용.
select to_char(hiredate,'YYYY') as "YEAR",
count(*) as "COUNT"
from emp
group by to_char(hiredate,'YYYY')
order by YEAR;

-- select 절에서 만든 별명(alias)는 where, group by, having 절에서는 사용할 수 없고,
-- order by 절에서는 사용 가능.

/*
 * select 문장의 순서:
 * select 칼럼, ...
 * from 테이블
 * where (그룹을 묶기 전에 검사할) 조건식
 * group by 그룹을 묶어줄 칼럼, ...
 * having 그룹을 묶은 다음에 조사할 검사식
 * order by 출력 순서를 결정할 칼럼, ...; 
 */
 
 -- 부서별 부서번호, 급여 평균을 검색.
 -- 부서별 급여 평균이 2000 이상인 부서들만 출력.
 -- 부서 번호 오름차순 정렬.
 
 select deptno,avg(sal)
 from emp
 group by deptno
 having avg(sal) >= 2000
 order by deptno;
 
 
 -- Ex. emp 테이블에서 mgr가 null이 아닌 직원들 중에서
-- 부서별 급여 평균을 검색. 부서 번호 오름차순 출력.
select deptno, round(avg(sal),2) as "AVG_SAL"
from emp
where mgr is not null
group by deptno
order by deptno;


-- Ex. 직책별 사원수를 검색.
-- 직책이 PRESIDENT는 제외.
-- 직책별 사원수가 3명 이상인 경우만 선택.
-- 직책 오름차순 출력.
select job,count(job) as "COUNT"
from emp
where job != 'PRESIDENT'
group by job
having count(job) >= 3 -- select에서 설정한 별명을 having에서 사용할 수 없음!
order by job;

select job, count(job)
from emp
group by job
having job != 'PRESIDENT' and count(job) >= 3
order by job;

-- Ex. 입사연도, 부서 번호, 입사연도별 부서별 입사한 사원수 검색.
-- 1980년 제외.
-- 연도별 부서별 사원수가 2명 이상인 경우 선택.
-- 연도 오름차순 출력.
select to_char(hiredate, 'YYYY') as "YEAR" , deptno, count(*) as "COUNT"
from emp
where to_char(hiredate, 'YYYY') != '1980'
group by to_char(hiredate, 'YYYY'), deptno
having count(*) >= 2
order by YEAR;
