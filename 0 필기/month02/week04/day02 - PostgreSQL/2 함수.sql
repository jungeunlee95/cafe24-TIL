-- 문자형 함수
select upper('seoul');

select upper(first_name) from employees;

SELECT LOWER('SEoul'); 

select substring('Happy Day', 3, 2);


SELECT concat( first_name, ' ', last_name ) AS 이름,
	 substring( to_char(hire_date, 'yyyy-mm-dd'), 1, 4) AS 입사년도
FROM employees
WHERE substring( to_char(hire_date, 'yyyy-mm-dd'), 1, 4) = '1989';

SELECT concat( first_name, ' ', last_name ) AS 이름,
	 to_char(hire_date, 'yyyy') AS 입사년도
FROM employees
WHERE to_char(hire_date, 'yyyy') = '1989';


select lpad('1234', 10, '-') lpad정렬;
select rpad('1234', 10, '-') rpad정렬;

SELECT emp_no, LPAD( cast(salary as char), 10, '*')      
  FROM salaries     
 WHERE to_char(from_date,'yyyy-mm-dd') like '2001-%'       
   AND salary < 70000;

select concat('---', LTRIM('   hello   '), '---') LTRIM,
	   concat('---', RTRIM('   hello   '), '---') RTIRM,
       concat('---', TRIM('   hello   '), '---') TIRM,
       concat('---', TRIM(both 'x' from 'xxxxHELLOxxxx'), '---') TIRM2;
    
      
      
-- 숫자형 함수

select abs(1), abs(-1);

select mod(234, 10), 234 % 10;

select floor(1.2345), floor(-1.2345);

select ceiling(1.2345), ceiling(-1.2345);

select round(-1.23), round(-1.58), round(1.58), round(1.298, 1);

select pow(2, 3), power(2, -3);

select sign(-10), sign(10), sign(0);

select sign(-10), sign(10), sign(0);

select greatest(98, 60, 30), greatest('B', 'A', 'CB', 'CA');

select least(98, 60, 30), least('B', 'A', 'CB', 'CA');



-- 날짜 함수
select current_date;

select current_time;

select now(), clock_timestamp(), current_timestamp;

select now(), pg_sleep(2), now();
select current_timestamp, pg_sleep(2), current_timestamp;
select clock_timestamp(), pg_sleep(2), clock_timestamp();

select to_date('2019-06-11', 'yyyy-mm-dd');
select to_date('2019-06-11', 'yyyy');
select to_date('2015-04-29 01:32:11.321', 'YYYY-MM-DD HH24:MI:SS.MS');

select to_char(now(), 'YYYY-MM-DD HH24:MI:SS.MS');

select date_part('year', current_date);
select date_part('year', now()) - date_part('year', current_date);

SELECT concat(first_name, ' ', last_name) AS name,               
       (date_part('year', now()) - date_part('year', hire_date))*12 +
       date_part('month', now()) - date_part('month', hire_date)
FROM employees;

-- casting
-- year, month, day, hour, minute, second, milllisecond
select now(), now() + interval'12 hours';
select now(), now() - interval'12 hours';

select first_name, 
	   hire_date,
       to_char((hire_date + interval'5 year'), 'yyyy-mm-dd')
from employees;

select now(), cast(now() as date);


-- 통계 함수
select avg(salary), sum(salary)
from salaries
where emp_no = '10060';

select emp_no, avg(salary)
from salaries
where to_char(from_date, 'yyyy') = '1985'
group by emp_no
having avg(salary) > 1000;

-- 예제4 : 각 사원별로 평균연봉 출력하되 50,000불 이상인 직원만 출력
   select emp_no, avg(salary) 
     from salaries
 group by emp_no
   having avg(salary) > 50000;

-- 예제5: (현재) 직책별로 (평균연봉)과 인원수를 구하되 직책별로 인원이 
--       100명 이상인 직책만 출력하세요.
   select title, count(emp_no)
     from titles
    where to_date = '9999-01-01' 
 group by title
   having count(emp_no) >= 100;


