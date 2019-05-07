[TOC]

---

# eXERD다운

![1557197225547](assets/1557197225547.png)



![1557200511358](assets/1557200511358.png)





# mariadb connector 다운

<https://downloads.mariadb.com/Connectors/java/connector-java-2.4.0/>





---

![1557197519416](assets/1557197519416.png)

![1557197530277](assets/1557197530277.png)

---



## webdb 계정 만들기

`mysql -p`

`create user 'webdb'@'192.168.%' identified by 'webdb';`

`grant all privileges on webdb.* to 'webdb'@'192.168.%' ;`

`flush privileges;`

`exit`

![1557202223113](assets/1557202223113.png)



---

## webdb schema 만들기

#### 비식별관계

![1557202400476](assets/1557202400476.png)

> 부서 번호를 주키로 안쓰겠당

#### 식별관계

![1557202476367](assets/1557202476367.png)

> FK이자 PK, 1:1 관계



---

#### 특성 설정

![1557202809773](assets/1557202809773.png)

![1557202781961](assets/1557202781961.png)





##  포워드 - DDL 생성

![1557202934048](assets/1557202934048.png)

![1557202957340](assets/1557202957340.png)

### JDBC 드라이버 선택

![1557203134113](assets/1557203134113.png)

#### mysql workbench에서 확인

![1557203353095](assets/1557203353095.png)

![1557203362253](assets/1557203362253.png)



---



---

## **join 확인 **

### 데이터넣기

```mysql
select * from employee;
select * from department;

-- outer join 
insert into department values(null, '총무팀');
insert into department values(null, '개발팀');
insert into department values(null, '인사팀');
insert into department values(null, '영업팀');

select * from department;

insert into employee values(null, '둘리', 1);
insert into employee values(null, '마이콜', 2);
insert into employee values(null, '또치', 3);
insert into employee values(null, '길동이', null);

select * from employee;
```

### - join ~ on (inner join)

```mysql
-- join ~ on (inner join)
select *
from employee a
join department b
on a.department_no = b.no;
```

> ![1557203825215](assets/1557203825215.png)



### - left join(outer join)

```mysql
-- left join(outer join)
select *
from employee a
left join department b
on a.department_no = b.no;

select a.name, ifnull(b.dept_name, '이름 없음')
from employee a
left join department b
on a.department_no = b.no;
```

> ![1557203867839](assets/1557203867839.png)
>
> ![1557203917796](assets/1557203917796.png)



### - right join(outer join)

```mysql
-- right join(outer join)
select ifnull(a.name,'이름 없음'), b.dept_name
from employee a
right join department b
on a.department_no = b.no;
```

> ![1557203983490](assets/1557203983490.png)



**full join은 mysql/mariadb 에서 지원 안함**

---



---

## 리버스 엔지니어링

![1557204158536](assets/1557204158536.png)

![1557204182827](assets/1557204182827.png)

![1557204229225](assets/1557204229225.png)