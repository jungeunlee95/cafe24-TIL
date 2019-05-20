-- select * from employees limit 0, 10;

select * from departments;

select first_name, last_name from employees where emp_no=10944;

select first_name, gender, hire_date from employees;

select concat(first_name, ' ', last_name) as 이름,
		gender 성별, hire_date 입사일 
from employees;

select distinct(title) 직급 from titles;

select concat(first_name, ' ', last_name) as 이름,
		gender 성별, 
		hire_date 입사일 
 from employees
 order by hire_date desc;
 
 select emp_no, salary, from_date
 from salaries
 where from_date like '2001%'
 order by salary desc;
 
 select concat(first_name, ' ', last_name) as 이름,
		gender 성별, 
		hire_date 입사일 
 from employees
 where hire_date < '1991-01-01'
 and gender='f';
 
 select emp_no, dept_no 
 from dept_emp
 where dept_no in ('d005', 'd009');
 
 
 
 
 
