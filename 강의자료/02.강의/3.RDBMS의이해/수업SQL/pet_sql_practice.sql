 insert
   into pet
values ( 'Fluffy', 'Harold', 'cat', 'f', '1999-02-04', null ); 

--insert
--  into pet(owner, name, species, gender)
--values (  'Harold2', 'Fluffy2','dog', 'f' ); 

load data local infile 'D:\pet.txt' into table pet;

select * 
 from pet
where name = 'Bowser';

select *
 from pet
where species = 'cat';  

select * from pet where species = 'dog' OR gender = 'm'; 

select * from pet where birth   > '1998-12-31';

select name, birth from pet where birth   > '1998-12-31';

   select * 
     from pet
   where owner = 'Harold'
order by name DESC, birth DESC; 


select * from pet where name = 'Fluffy';
    
select * from pet where name LIKE '%ff%';

select * from pet where name LIKE '%y';

select * from pet where name LIKE 'B%';

select * from pet where name LIKE '____';  -- 이름이 4자 인 놈

select count(*) from pet;

select count(*) from pet where owner = 'Harold';

delete from pet where owner = 'Harold';

select * from pet;

update pet
     set gender = null,
	      death = '2016-3-17'
where gender = 'm'; 
