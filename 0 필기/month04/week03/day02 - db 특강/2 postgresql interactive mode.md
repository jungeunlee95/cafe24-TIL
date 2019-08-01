[TOC]

---

1 - `/cafe24/pgsql/bin/psql --host=localhost --port=9999 --username=postgres --dbname=template1`

2- `/cafe24/pgsql/bin/psql -p 9999 -U postgres -d template1` -> 더 빠름

---



---

# PostgreSQL｜psql 사용

Objective

psql(PostgreSQL interactive terminal)를 이용해 쿼리를 실행시키는 방법 

 

# 1. 해당 데이터베이스에 접속해 대화형 모드(interactive mode)로 쿼리를 실행

```
[root@host ~]# /home/postgresql/bin/psql --port=9999 --username=postgres --dbname=mall
psql (9.2.14)
Type "help" for help.
 
mall=# CREATE TABLE t_psql (key_no INTEGER NOT NULL, set_value TEXT NULL, CONSTRAINT pk_psql PRIMARY KEY (key_no)) WITHOUT OIDS;
NOTICE:  CREATE TABLE / PRIMARY KEY will create implicit index "pk_psql" for table "t_psql"
CREATE TABLE
 
mall=# \q
[root@host ~]#
```

 

# 2. --command 옵션에 쿼리를 지정해서 실행

```
[root@host ~]# /home/postgresql/bin/psql --port=9999 --username=postgres --dbname=mall --command="INSERT INTO t_psql (key_no, set_value) VALUES (1, 'a');"
INSERT 0 1
```

 

![설명: (정보)](file:///C:\Users\BIT\AppData\Local\Temp\msohtmlclip1\01\clip_image002.png) 이 방법에서는 가장 마지막 SQL문에 대한 결과 메시지만 출력/리턴된다.

```
[root@host ~]# /home/postgresql/bin/psql --port=9999 --username=postgres --dbname=mall --command="SELECT version(); SELECT * FROM t_psql;"
 key_no | set_value
--------+-----------
      1 | a
(1 row)
```

- SELECT 문이      여러개라 하더라도 가장 마지막 SELECT 명령 결과만 출력
- 지정된 SQL문      길이가 너무 길면 "bin/psql: Argument list too long" 에러가      발생한다.

 

![설명: (정보)](file:///C:\Users\BIT\AppData\Local\Temp\msohtmlclip1\01\clip_image002.png) 일반적인 SQL 명령뿐만 아니라 내부에 지정된 매크로(interactive mode에서 사용하는 backslash command)도 실행 가능하다.

```
[root@host ~]# /home/postgresql/bin/psql --port=9999 --username=postgres --dbname=mall --command="\dt" --echo-hidden
********* QUERY **********
SELECT n.nspname as "Schema",
  c.relname as "Name",
  CASE c.relkind WHEN 'r' THEN 'table' WHEN 'v' THEN 'view' WHEN 'i' THEN 'index' WHEN 'S' THEN 'sequence' WHEN 's' THEN 'special' WHEN 'f' THEN 'foreign table' END as "Type",
  pg_catalog.pg_get_userbyid(c.relowner) as "Owner"
FROM pg_catalog.pg_class c
     LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
WHERE c.relkind IN ('r','')
      AND n.nspname <> 'pg_catalog'
      AND n.nspname <> 'information_schema'
      AND n.nspname !~ '^pg_toast'
  AND pg_catalog.pg_table_is_visible(c.oid)
ORDER BY 1,2;
**************************
                  List of relations
 Schema |           Name           | Type  |  Owner
--------+--------------------------+-------+----------
 public | t_psql                   | table | postgres
 public | t_table_create_statement | table | postgres
(2 rows)
```

- --echo-hidden      옵션은 이 매크로의 실제 쿼리를 출력하게 해준다.
- SQL 명령과      매크로를 혼합으로 사용하는 것은 허용하지 않으며, 매크로일 경우 하나의 명령만 실행할 수 있다.

 

![설명: (정보)](file:///C:\Users\BIT\AppData\Local\Temp\msohtmlclip1\01\clip_image002.png) --command에 지정된 모든 SQL은 단일(single) 트랜잭션으로 처리되며, 내부에 BEGIN/COMMIT 명령을 포함한 트랜잭션 구간이 별도로 존재하더라도 에러가 발생하면 모두 롤백된다.

```
[root@host ~]# /home/postgresql/bin/psql --port=9999 --username=postgres --dbname=mall --command="
INSERT INTO t_psql (key_no, set_value) VALUES (2, 'bb');
BEGIN;
INSERT INTO t_psql (key_no, set_value) VALUES (3, 'ccc');
END;
INSERT INTO t_psql (key_no, set_value) BALUES (4, 'dddd');
INSERT INTO t_psql (key_no, set_value) VALUES (5, 'eeeee');
"
ERROR:  syntax error at or near "BALUES"
LINE 6: INSERT INTO t_psql (key_no, set_value) BALUES (4, 'dddd');
                                               ^
[root@host ~]# echo $?
1
```

![설명: (warning)](file:///C:\Users\BIT\AppData\Local\Temp\msohtmlclip1\01\clip_image004.png) 에러가 발생하는 경우 Exit Status 코드에서 에러값을 확인할 수 있다.

- 0: 성공
- 1: 명령      오류
- 2: 커넥션      오류
- 3:      ON_ERROR_STOP 옵션이 설정됐을 경우 발생하는 오류

 

# 3. Redirection, Pipe를 통한 Standard Input 실행

```
[root@host ~]# echo "INSERT INTO t_psql (key_no, set_value) VALUES (2, 'bb');" | /home/postgresql/bin/psql --port=9999 --username=postgres --dbname=mall
INSERT 0 1
 
[root@host ~]# /home/postgresql/bin/psql --port=9999 --username=postgres --dbname=mall <<EOF
INSERT INTO t_psql (key_no, set_value) VALUES (3, 'ccc');
EOF
INSERT 0 1
 
[root@host ~]# echo "SELECT * FROM t_psql;" > ~/tmp.sql
[root@host ~]# /home/postgresql/bin/psql --port=9999 --username=postgres --dbname=mall < ~/tmp.sql
 key_no | set_value
--------+-----------
      1 | a
      2 | bb
      3 | ccc
(3 rows)
```

 

![설명: (정보)](file:///C:\Users\BIT\AppData\Local\Temp\msohtmlclip1\01\clip_image002.png) 입력 명령 전체가 하나의 트랜잭션으로 묶이지도 않으며, SQL문에 오류가 존재하는 경우 Exit Status 코드를 제대로 얻지 못한다.

```
[root@host ~]# echo "INSERT INTO t_psql (key_no, set_value) VALUES (4, 'dddd'); SELECT * GROM t_psql;" | /home/postgresql/bin/psql --port=9999 --username=postgres --dbname=mall
INSERT 0 1
ERROR:  syntax error at or near "GROM"
LINE 1: SELECT * GROM t_psql;
                 ^
[root@host ~]# echo $?
0
[root@host ~]# echo "SELECT * FROM t_psql;" | /home/postgresql/bin/psql --port=9999 --username=postgres --dbname=mall
 key_no | set_value
--------+-----------
      1 | a
      2 | bb
      3 | ccc
      4 | dddd
(4 rows)
```

 

# 4. --file 옵션을 통한 실행

```
[root@host ~]# /home/postgresql/bin/psql --port=9999 --username=postgres --dbname=mall --file=tmp.sql
 key_no | set_value
--------+-----------
      1 | a
      2 | bb
      3 | ccc
      4 | dddd
(4 rows)
```

 

![설명: (정보)](file:///C:\Users\BIT\AppData\Local\Temp\msohtmlclip1\01\clip_image002.png) 파일에 저장된 SQL문에 오류가 존재하는 경우 Exit Status 코드를 제대로 얻지 못한다. 하지만 --file 옵션을 사용하면 오류가 발생하는 라인 번호를 출력해준다.

```
[root@host ~]# /home/postgresql/bin/psql --port=9999 --username=postgres --dbname=mall --file=tmp1.sql
tmp1.sql: 그런 파일이나 디렉터리가 없습니다
[root@host ~]# echo $?
1
 
[root@host ~]# echo "SELECT * GROM t_psql;" > ~/tmp1.sql
[root@host ~]# /home/postgresql/bin/psql --port=9999 --username=postgres --dbname=mall --file=tmp1.sql
psql:tmp1.sql:1: ERROR:  syntax error at or near "GROM"
LINE 1: SELECT * GROM t_psql;
                 ^
[root@host ~]# echo $?
0
```

 

![설명: (tick)](file:///C:\Users\BIT\AppData\Local\Temp\msohtmlclip1\01\clip_image006.png) psql --file=filename 옵션을 사용하는 방법은 psql < filename 방법과 매우 유사하지만 다소 차이가 있다.

- 우선 에러가 발생하는 경우 메시지에 발생 위치(line number)를 포함하기 때문에 유용하고,
- start-up 시에      오버헤드를 감소시키는 효과를 볼 수 있다.

 

# 5. Standard Input(Pipe) + --file 옵션 사용

```
[root@host ~]# echo "SELECT * FROM t_psql;" | /home/postgresql/bin/psql --port=9999 --username=postgres --dbname=mall --file=-
 key_no | set_value
--------+-----------
      1 | a
      2 | bb
      3 | ccc
(3 rows)
```

- --file 옵션에서      값을 hyphen(-)으로 지정하면 standard      input을 의미한다.

 

![설명: (정보)](file:///C:\Users\BIT\AppData\Local\Temp\msohtmlclip1\01\clip_image002.png) 마찬가지로 그냥 사용하면 Exit Status에서 오류 코드를 검출하지 못한다. 하지만 "ON_ERROR_STOP=1" 옵션을 포함하는 경우 오류 코드를 확인할 수 있다.

```
[root@host ~]# echo "SELECT * GROM t_psql;" | /home/postgresql/bin/psql --port=9999 --username=postgres --dbname=mall --file=- --set="ON_ERROR_STOP=on"
psql:<stdin>:1: ERROR:  syntax error at or near "GROM"
LINE 1: SELECT * GROM t_psql;
                 ^
[root@host ~]# echo $?
3
```

 

![설명: (정보)](file:///C:\Users\BIT\AppData\Local\Temp\msohtmlclip1\01\clip_image002.png) 트랜잭션을 위해서는 AUTOCOMMIT 설정을 이용한다.

```
[root@host ~]# echo "
INSERT INTO t_psql (key_no, set_value) VALUES (5, 'eeeee');
INSERT INTO t_psql (key_no, set_value) BALUES (6, 'ffffff');
COMMIT;
" | /home/postgresql/bin/psql --port=9999 --username=postgres --dbname=mall --set="ON_ERROR_STOP=on" --set="AUTOCOMMIT=off"
INSERT 0 1
ERROR:  syntax error at or near "BALUES"
LINE 1: INSERT INTO t_psql (key_no, set_value) BALUES (6, 'ffffff');
                                               ^
[root@host ~]# echo $?
3
[root@host ~]# echo "SELECT * FROM t_psql;" | /home/postgresql/bin/psql --port=9999 --username=postgres --dbname=mall
 key_no | set_value
--------+-----------
      1 | a
      2 | bb
      3 | ccc
      4 | dddd
(4 rows)
 
[root@host ~]# LV_SQL_RESULT=$(echo "SELECT * GROM t_psql;" | /usr/local/pgsql80/bin/psql --port=8001 --username=postgres --dbname=mall --file=- --set="ON_ERROR_STOP=on" 2>&1)
[root@host ~]# echo $?
3
[root@host ~]# echo "${LV_SQL_RESULT}"
psql:<stdin>:1: ERROR:  syntax error at or near "GROM" 위치: 10
psql:<stdin>:1: 줄 1: SELECT * GROM t_psql;
psql:<stdin>:1:                 ^
```

- --command 옵션의      경우 에러가 하나라도 있으면 전체가 롤백되는 트랜잭션이 지원되는 반면, Standard      Input/--file 옵션 모두 단일 트랜잭션이 지원되지 않는다.
- 이유는      Standard Input/--file 옵션 환경에서 각 SQL 명령이 실행될      때마나 자동으로 commit되기 때문이다. 즉 내부적으로 AUTOCOMMIT 설정이 on(true)인 것이다.
- 이 설정은 서버 레벨에서는 변경할 수 없지만 클라이언트      세션에서는 값을 off로 설정할 수가 있다. 이러면      각 SQL 문이 자동으로 즉시 실행되지 않고, 하나의      트랜잭션으로 묶여서 최종 명령이 종료될 때 COMMIT되게 된다.
- 이 옵션을 사용하면      SELECT 명령에 대한 결과는 얻을 수 있지만, 데이터를 변경하고자 하는 경우에는 마지막에 명시적으로 COMMIT; 명령을      포함해야 적용된다.
- 실행 쿼리 내부에 트랜잭션 구간(BEGIN; ~ END;)이 존재하면 외부와는 별도로 처리. 즉      내부 트랜잭션 구간에 오류가 없다면 외부 트랜잭션이 롤백되더라도 실행됨.
- 외부 쿼리는 전체가 트랜잭션 구간이므로 오류가 발생하면      롤백됨/내부 트랜잭션에 의한 오류도 역시 롤백을 만들어냄

 

--set="ON_ERROR_STOP=off" --set="AUTOCOMMIT=on" 

- 기본값
- 오류가 발생하더라도 계속 진행하고, 오류가 없는 명령들은 모두 실행
- STDIN 입력인      경우 EXIT STATUS에 (마지막 명령이 에러를      유발하더라도) 에러코드가 안 남게됨/메시지 내에서 ERROR:/FATAL: 존재여부로 오류 파악

 

--set="ON_ERROR_STOP=off" --set="AUTOCOMMIT=off" 

- 오류가 발생하더라도 계속 진행하고, 완료되면 모두 롤백
- 일반적으로 오류가 발생하면 이후 명령은 진행하지 않기      때문에 사용할 경우는 거의 없겠지만, 전체 오류가 어디에서 발생하는지 파악하고 싶은 경우에      사용할 수 있을 것으로 보임
- 트랜잭션 모드이므로 오버헤드 있음
- STDIN 입력인      경우 EXIT STATUS에 (마지막 명령이 에러를      유발하더라도) 에러코드가 안 남게됨/메시지 내에서 ERROR:/FATAL: 존재여부로 오류 파악

 

--set="ON_ERROR_STOP=on" --set="AUTOCOMMIT=on" 

- 오류가 발생하면 중지하고, 오류 이전까지 정상 명령만 실행
- STDIN 입력인      경우 EXIT STATUS에 에러코드 3

 

--set="ON_ERROR_STOP=on" --set="AUTOCOMMIT=off" 

- 오류가 발생하면 중지하고, 즉시 모두 롤백
- 트랜잭션 모드이므로 오버헤드 있음
- STDIN 입력인      경우 EXIT STATUS에 에러코드 3
- 가장 일반적인 사용 설정

 

![설명: (전구)](file:///C:\Users\BIT\AppData\Local\Temp\msohtmlclip1\01\clip_image008.png) PostgreSQL 8.2 버전부터 --single-transaction 옵션을 지원한다.

- --single-transaction      옵션은 가장 바깥쪽에 BEGIN; ~ END; 감싸는 효과
- 즉 내부에 명시적인 트랜잭션 시작 구문(BEGIN;)을 만나게 되면 중복이므로 WARNING(there is      already a transaction in progress)이 발생하고,
- 트랜잭션 종료 구문(END;)과 함께 모든 트랜잭션은 종료됨
- 제일 마지막에 보이지 않는 END; 구문이 있기 때문에 마찬가지로 WARNING(there is      no transaction in progress)이 발생
- AUTOCOMMIT=off      설정을 사용하는 편이 좋다.

 

![설명: (빼기)](file:///C:\Users\BIT\AppData\Local\Temp\msohtmlclip1\01\clip_image010.png) VACUUM 명령은 트랜잭션 내에서 실행된다면 어디에서건 오류를 만들어낸다.

 















































