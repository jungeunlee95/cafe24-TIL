```mysql
-- 서브쿼리(SUBQUERY) SQL 문제입니다.

-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
select count(*)
from salaries 
where salary > (
		select avg(salary)
		from salaries
        where to_date = '9999-01-01')
and to_date = '9999-01-01';
 
-- 문제2.   
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요. 
-- 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
-- <1>
  select a.emp_no, concat(a.first_name,' ',a.last_name), d.dept_name, b.salary
 from employees a, salaries b, dept_emp c, departments d
 where a.emp_no = b.emp_no
 and a.emp_no = c.emp_no
 and d.dept_no = c.dept_no
 and b.to_date='9999-01-01'
 and c.to_date='9999-01-01'
 and (c.dept_no, b.salary) =any( select c.dept_no, max(b.salary) as max_salary
								 from employees a, salaries b, dept_emp c
								 where a.emp_no = b.emp_no
								 and a.emp_no = c.emp_no
								 and b.to_date='9999-01-01'
								 and c.to_date='9999-01-01'
								 group by c.dept_no)
order by b.salary desc;
                                 
-- <2>
select e.emp_no, concat(e.first_name,' ',e.last_name), d.dept_name, s.salary 
from employees e, departments d, salaries s, dept_emp de
where e.emp_no = s.emp_no
and e.emp_no = de.emp_no
and d.dept_no = de.dept_no
and s.to_date = '9999-01-01'
and de.to_date = '9999-01-01'
and (de.dept_no, s.salary) in (select d.dept_no, max(s.salary)
				from dept_emp d, salaries s
				where d.emp_no = s.emp_no
				and s.to_date = '9999-01-01'
				and d.to_date = '9999-01-01'
				group by d.dept_no)
order by s.salary desc;


-- 문제3.
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 
-- from
select e.emp_no, concat(e.first_name,' ',e.last_name), s.salary
from employees e, salaries s, dept_emp de, (select d.dept_no, avg(s.salary) as avg_salary
											from employees e, dept_emp d, salaries s
											where e.emp_no = d.emp_no
											and e.emp_no = s.emp_no
											and d.to_date='9999-01-01'
											and s.to_date='9999-01-01'
											group by d.dept_no) A
where e.emp_no = s.emp_no
and e.emp_no = de.emp_no
and s.to_date='9999-01-01'
and de.to_Date='9999-01-01'
and de.dept_no = A.dept_no
and s.salary > A.avg_salary
order by s.salary desc;

-- where  : 왜안되지... 어떻게 해야할까
select e.emp_no, concat(e.first_name,' ',e.last_name), s.salary
from employees e, salaries s, dept_emp de
where e.emp_no = s.emp_no
and e.emp_no = de.emp_no
and s.to_date='9999-01-01'
and de.to_date='9999-01-01'
and (de.dept_no, s.salary) > (select d.dept_no, avg(s.salary) as avg_salary
											from employees e, dept_emp d, salaries s
											where e.emp_no = d.emp_no
											and e.emp_no = s.emp_no
											and d.to_date='9999-01-01'
											and s.to_date='9999-01-01'
											group by d.dept_no);



-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
select e.emp_no, concat(e.first_name,' ',e.last_name), d.dept_name, A.mname
from employees e, dept_emp de, departments d, (select dm.dept_no, dm.emp_no, concat(e.first_name,' ',e.last_name) mname
												from dept_manager dm, employees e
												where dm.emp_no = e.emp_no
												and dm.to_date = '9999-01-01')A
where e.emp_no = de.emp_no
and de.dept_no = A.dept_no
and de.dept_no = d.dept_no
and de.to_date='9999-01-01';


-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
select e.emp_no, concat(e.first_name,' ',e.last_name), t.title, s.salary, de.dept_no
from employees e, titles t, salaries s, dept_emp de
where e.emp_no = t.emp_no
and e.emp_no = s.emp_no
and e.emp_no = de.emp_no
and de.dept_no = (select de.dept_no
					from dept_emp de, salaries s
					where de.emp_no = s.emp_no
					and de.to_date='9999-01-01'
					and s.to_date='9999-01-01'
					group by de.dept_no
					order by avg(s.salary) desc
					limit 1)
order by s.salary desc;



-- 문제6.
-- 평균 연봉이 가장 높은 부서는?
select d.dept_name, de.dept_no
from departments d, dept_emp de
where d.dept_no = de.dept_no
and de.dept_no = (select d.dept_no
					from employees e, dept_emp d, salaries s
					where e.emp_no = d.emp_no
					and e.emp_no = s.emp_no
					and d.to_date='9999-01-01'
					and s.to_date='9999-01-01'
					group by d.dept_no
					order by avg(s.salary) desc
					limit 1)
group by d.dept_name;
										

-- 문제7.
-- 평균 연봉이 가장 높은 직책?
select t.title, avg(s.salary) avg_salary
from titles t, salaries s
where t.emp_no = s.emp_no
and t.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
group by t.title
order by avg_salary desc
limit 1;


-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
select concat(e.first_name,' ',e.last_name) employee_name, s.salary employee_salary, 
		A.mname manager_name, A.msalary manager_salary
from employees e, departments d, salaries s, dept_emp de, 
		( select dm.dept_no, dm.emp_no, concat(e.first_name,' ',e.last_name) mname, s.salary msalary
			from dept_manager dm, employees e, salaries s
			where dm.emp_no = e.emp_no
			and e.emp_no = s.emp_no
			and dm.to_date = '9999-01-01'
			and s.to_date = '9999-01-01' ) A
where e.emp_no = s.emp_no
and e.emp_no = de.emp_no
and de.dept_no = d.dept_no
and de.dept_no = A.dept_no
and s.to_date = '9999-01-01'
and de.to_date = '9999-01-01'
and s.salary > A.msalary;
                                                

-- 부서의 매니저
select dm.dept_no, dm.emp_no, concat(e.first_name,' ',e.last_name) mname, s.salary
from dept_manager dm, employees e, salaries s
where dm.emp_no = e.emp_no
and e.emp_no = s.emp_no
and dm.to_date = '9999-01-01'
and s.to_date = '9999-01-01' ;







```

