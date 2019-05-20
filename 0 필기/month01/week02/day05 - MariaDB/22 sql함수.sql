select upper('seoul'), ucase('seoul');

select upper(first_name) from employees;

SELECT LOWER('SEoul'), LCASE('seOUL'); 

select substring('Happy Day', 3, 2);

SELECT concat( first_name, ' ', last_name ) AS 이름,
	 substring( hire_date, 1, 4) AS 입사년도
FROM employees
WHERE substring( hire_date, 1, 4) = '1989';

select lpad('1234', 10, '-') lpad정렬;
select rpad('1234', 10, '-') rpad정렬;

SELECT emp_no, LPAD( cast(salary as char), 10, '*')      
  FROM salaries     
 WHERE from_date like '2001-%'       
   AND salary < 70000;

select concat('---', LTRIM('   hello   '), '---') LTRIM,
	   concat('---', RTRIM('   hello   '), '---') RTIRM,
       concat('---', TRIM('   hello   '), '---') TIRM,
       concat('---', TRIM(both 'x' from 'xxxxHELLOxxxx'), '---') TIRM2;

-- 날짜 함수
select curdate(), current_date();

select curtime(), current_time();

select now(), sysdate(), current_timestamp();

select now(), sleep(2), now();
select sysdate(), sleep(2), sysdate();

select date_format(now(), '%Y년 %c월 %d일 %h시 %i분 %s초');
select date_format(now(), '%Y-%c-%d  %h:%i:%s');

SELECT concat(first_name, ' ', last_name) AS name,               
       PERIOD_DIFF( DATE_FORMAT(CURDATE(), '%Y%m'),  
                    DATE_FORMAT(hire_date, '%Y%m') )
  FROM employees;


select first_name, 
	   hire_date,
       date_add(hire_date, interval 5 year) -- day, month, year
from employees;

select now(), cast(now() as date);
select cast(1-2 as unsigned);

-- 통계 함수
select avg(salary), sum(salary)
from salaries
where emp_no = '10060';












