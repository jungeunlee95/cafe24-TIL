[TOC]

# Subquery

> - 서브쿼리는 괄호로 묶여야함
> - 서브쿼리 내에 `order by` 금지
> - `group by`절 외에 거의 모든 구문에서 사용가능
> - 형식 연산자
>   - **단일행** 연산자 ( =, >,  >=,  <, <=, <> )
>   - **복수행** 연산자 ( IN, ANY, ALL, NOT IN )  



### 결과가 하나인 경우(단일행)

> **단일행 연산자 ( =, >,  >=,  <, <=, <> )**

```mysql
-- 현재 Fai Bale이 근무하는 부서에서 근무하는 직원의 사번, 전체 이름을 출력
-- 부서찾기
select b.dept_no
from employees a, dept_emp b
where a.emp_no = b.emp_no
and b.to_date='9999-01-01'
and concat(a.first_name,' ',a.last_name) = 'Fai Bale';

-- 그 부서 직원들 찾기
select a.emp_no, concat(a.first_name,' ',a.last_name)
from employees a, dept_emp b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and b.dept_no = 'd004';

-- subquery로 한번에
select a.emp_no, concat(a.first_name,' ',a.last_name)
from employees a, dept_emp b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and b.dept_no = (select b.dept_no
				from employees a, dept_emp b
				where a.emp_no = b.emp_no
				and b.to_date='9999-01-01'
				and concat(a.first_name,' ',a.last_name) = 'Fai Bale');
	
    
    
    
    
-- 실습문제 1: 현재 전체사원의 평균 연봉보다 적은 급여를 받는 사원의 이름, 급여 출력
select concat(a.first_name,' ',a.last_name) 이름, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and b.salary < (select avg(salary)
			    from salaries
				where to_date = '9999-01-01');
			
            
            
            

-- 실습문제 2: 현재 가장적은 평균 급여를 받고 있는 직책에 대해서 평균 급여 출력   
-- 1번째 방법 : TOP-K(order by 후에 top부터 k개를 빼내는 것)
select b.title, avg(a.salary)
from salaries a, titles b
where a.emp_no = b.emp_no
and a.to_date='9999-01-01'
and b.to_date='9999-01-01'
group by b.title
having avg(a.salary) = (select avg(a.salary)
						from salaries a, titles b
						where a.emp_no = b.emp_no
						and a.to_date='9999-01-01'
						and b.to_date='9999-01-01'
						group by b.title
						order by avg(a.salary)
						limit 1);
                        
-- 2번째 방법 
select b.title, avg(a.salary)
from salaries a, titles b
where a.emp_no = b.emp_no
and a.to_date='9999-01-01'
and b.to_date='9999-01-01'
group by b.title
having round(avg(a.salary)) = (select min(avg_salary)
								from( select round(avg(a.salary)) as avg_salary
										from salaries a, titles b
										where a.emp_no = b.emp_no
										and a.to_date='9999-01-01'
										and b.to_date='9999-01-01'
										group by b.title) a);
										
-- 3번째 방법 : JOIN만으로 풀어보깅 
-- 사실 1번째 방법에서 굳이 서브쿼리 쓸 이유가 없음
select b.title, avg(a.salary) avg_salary
from salaries a, titles b
where a.emp_no = b.emp_no
and a.to_date='9999-01-01'
and b.to_date='9999-01-01'
group by b.title
order by avg_salary
limit 1;	
```





### 결과가 여러개인 경우(복수,다중행)

> **복수행 연산자 ( IN, ANY, ALL, NOT IN )**  
>
> > **any 사용법 :** 
> >
> > 1. `=any` :`in`과 완전 동일
> > 2. `>any `, `>=any` : 최솟값 반환
> > 3. `<any`, `<=any` : 최댓값 반환
> > 4. `<>any`  :  `!=all` 과 동일
> >
> > **all 사용법 :**
> >
> > 1. `=all`
> > 2. `>all`, `>=all` : 최댓값 반환
> > 3. `<all`, `<=all` : 최솟값 반환

**문제 1**

```mysql
-- 결과가 여러개인 경우(복수,다중행)
-- 문제1 :  현재 급여가 50000 이상인 직원 이름 subquery

-- 조인만으로도 풀 수 있는 문제이긴 함
-- in, =any
select concat(a.first_name, ' ', a.last_name), b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and (a.emp_no, b.salary) in (select emp_no, salary
							from salaries
							where to_date = '9999-01-01'               
							and salary > 50000);        
                
select concat(a.first_name, ' ', a.last_name), b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and (a.emp_no, b.salary) =any (select emp_no, salary
							from salaries
							where to_date = '9999-01-01'               
							and salary > 50000);   
                            
-- from 절에 subquery
select concat(a.first_name, ' ', a.last_name), b.salary		
from employees a, (select emp_no, salary
                    from salaries
                    where to_date = '9999-01-01'               
                    and salary > 50000) b
where a.emp_no = b.emp_no;    
```



**문제2**

```mysql
-- 문제 2:  각 부서별로 최고 월급을 받는 직원의 이름과 월급 출력
 select c.dept_no, max(b.salary) as max_salary
 from employees a, salaries b, dept_emp c
 where a.emp_no = b.emp_no
 and a.emp_no = c.emp_no
 and b.to_date='9999-01-01'
 and c.to_date='9999-01-01'
 group by c.dept_no;
 
 -- 1 where 절에 subquery사용해보기
  select a.first_name, c.dept_no, b.salary
 from employees a, salaries b, dept_emp c
 where a.emp_no = b.emp_no
 and a.emp_no = c.emp_no
 and b.to_date='9999-01-01'
 and c.to_date='9999-01-01'
 and (c.dept_no, b.salary) =any( select c.dept_no, max(b.salary) as max_salary
								 from employees a, salaries b, dept_emp c
								 where a.emp_no = b.emp_no
								 and a.emp_no = c.emp_no
								 and b.to_date='9999-01-01'
								 and c.to_date='9999-01-01'
								 group by c.dept_no);
 -- 1 from 절에 subquery사용해보기
  select a.first_name, c.dept_no, b.salary
 from employees a, salaries b, dept_emp c,
	  ( select c.dept_no, max(b.salary) as max_salary
		 from employees a, salaries b, dept_emp c
		 where a.emp_no = b.emp_no
		 and a.emp_no = c.emp_no
		 and b.to_date='9999-01-01'
		 and c.to_date='9999-01-01'
		 group by c.dept_no) d
 where a.emp_no = b.emp_no
 and a.emp_no = c.emp_no
 and c.dept_no = d.dept_no
 and b.to_date='9999-01-01'
 and c.to_date='9999-01-01'
 and b.salary = d.max_salary;
```

> 원래 시간 차이가 나는데, 별 차이가 안나네 
>
> -> 원래 where절이 더 빠름, 가능한 where절에 subquery넣는 것을 추천
>
> -> **BUT**,  from절에 넣어야만 해결되는 것도 있으니, where절만 고집하진 말자