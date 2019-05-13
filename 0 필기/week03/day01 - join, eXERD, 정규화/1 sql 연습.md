[TOC]

---

## 쿼리 순서

```MYSQL
SELECT 
	FROM	
WHERE
```

> FROM으로 FULL SCAN하고 
>
> WHERE보고(없으면 바로 SELECT)
>
> 조건 해당 값 빼내고 출력, 빼내고 출력, 빼내고 출력



```MYSQL
SELECT 
	FROM	
WHERE
ORDER BY
```

> `FROM`으로 FULL SCAN하고 
>
> `WHERE`보고(없으면 바로 `SELECT`)
>
> 조건 해당 값 빼내고 --> 새로운 임시 테이블 만들어서 정렬하고 출력!
>
> ==>` ORDER BY`는 느림



```mysql
SELECT 일반컬럼, 집계함수(SUM, AVG ..)
	FROM
WHERE
```

> `FROM`으로 FULL SCAN하고 
>
> `WHERE`보고
>
> 조건 해당 값을 골라 `SUM`작업을 해서 출력



```mysql
SELECT 일반컬럼, 집계함수(SUM, AVG ..)
	FROM
WHERE
GROUP BY
```

> `FROM`으로 FULL SCAN하고 
>
> `WHERE`절에서 해당 값을 가져와서
>
> `GROUP BY`조건(컬럼)에 맞춰 임시테이블을 만듦



```mysql
SELECT 일반컬럼, 집계함수(SUM, AVG ..)
	FROM
WHERE
GROUP BY
HAVING
```

> `GROUP BY`된 임시 테이블에 조건을 걸 떄
>
> `HAVING` !!!!! 



```MYSQL
SELECT 일반컬럼, 집계함수(SUM, AVG ..)
	FROM
WHERE
GROUP BY
HAVING
ORDER BY
LIMIT
```

> `FROM` 테이블의
>
> `WHERE` 조건에 따라
>
> `SELECT` 해서, 
>
> `GROUP BY` 컬럼에 맞춰 그룹화하고
>
> `HAVING` 그룹화된 임시 테이블에 조건을 걸고
>
> `ORDER BY`로 정렬한뒤
>
> `LIMIT`을 통해 범위를 뽑아서 가져다 올림 
>
> ==> 모든 작업이 끝난 뒤 `LIMIT`되기 때문에 속도 상에 큰 차이는 없음
>
> ==> 네트워크 상에서 데이터 양이 차이가 있지, DB에서 쿼리상 속도는 차이 XXX

---



---

## sql 연습

### 예제 1 : 각 사원별로 평균 연봉 출력

```mysql
-- 1
  select emp_no, avg(salary)
	from salaries
group by emp_no;


-- 2 - 이름(join)
  select concat(e.first_name, ' ', e.last_name), avg(s.salary)
	from salaries s, employees e
    where s.emp_no = e.emp_no
group by s.emp_no;

-- 3
 select emp_no, avg(salary)
	from salaries
group by emp_no
order by avg(salary) desc;
```



### 예제 2 : 각 현재 Manager 직책 사원에 대한 평균 연봉은?

```mysql
select count(*)
from titles
group by title
having title = 'Manager';

select count(*)
from dept_manager;
```

> **titles 테이블과 dept_manager 테이블 둘 다 사용 가능**

```mysql
select d.emp_no, avg(salary)
from dept_manager d, salaries s
where d.emp_no = s.emp_no
group by s.emp_no;

select t.emp_no, avg(salary)
from titles t, salaries s
where t.emp_no = s.emp_no
and t.title = 'Manager'
group by s.emp_no;
```



### 예제 3 : 사원 별 몇번의 직책 변경이 있었는지 조회

```mysql
   select emp_no, count(title)
	 from titles
 group by emp_no;
```



### 예제4 **:** 각 사원별로 평균연봉 출력하되 50,000불 이상인 직원만 출력 

```mysql
select emp_no, avg(salary) as avgs
from salaries
group by emp_no
having avgs > 50000;
```



### 예제5: 현재 직책별 평균 연봉과 인원수를 구하되 직책별로 인원이 100명 이상인 직책만 출력

```mysql
select title, count(emp_no)
from titles
where to_date = '9999-01-01'
group by title
having count(emp_no) > 100;
```



### 예제 6: 현재 부서별 현재 직책이 Engineer인 직원들만 평균급여 출력

```mysql
select c.dept_no, d.dept_name, avg(a.salary)
 from salaries a, titles b, dept_emp c, departments d
where a.emp_no = b.emp_no
	and b.emp_no = c.emp_no
    and c.dept_no = d.dept_no
	and a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'
	and b.title = 'Engineer'
group by c.dept_no;

-- Engineer인 직원들에 대해서만 평균급여를 구하세요.
select t.emp_no, avg(s.salary)
from salaries s, titles t
where s.emp_no = t.emp_no
and s.to_date = '9999-01-01'
and t.to_date = '9999-01-01'
and t.title = 'Engineer'
group by t.emp_no;
```



### 예제 7

> 현재 직책별로 급여의 총합을 구하되 Engineer직책은 제외하세요
> 단, 총합이 2,000,000,000이상인 직책만 나타내며 급여총합에
> 대해서 내림차순(DESC)로 정렬하세요.   

```mysql
-- EXPLAIN
select t.title, sum(s.salary) sum_salary
from titles t, salaries s
where t.emp_no = s.emp_no
and t.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
and t.title != 'Engineer'
group by t.title
having sum_salary > 2000000000
order by sum_salary desc;
```

