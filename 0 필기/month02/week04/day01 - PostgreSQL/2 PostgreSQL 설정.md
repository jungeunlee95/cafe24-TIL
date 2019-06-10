[TOC]

---

## 사용자 추가

`psql -U postgres`

`create user webdb with password 'webdb';`



## 테이블에 대한 권한 추가

`\dn`

`grant all privileges on all tables in schema public to webdb;`

> ![1560132317772](assets/1560132317772.png)



## 연결 설정

> /usr/local/cafe24/pgsql/data/pg_hba.conf

`vi /cafe24/pgsql/data/pg_hba.conf`

![1560132562557](assets/1560132562557.png)

`killall postgres`

`sudo -u postgres /usr/local/cafe24/pgsql/bin/pg_ctl -D /usr/local/cafe24/pgsql/data -l /usr/local/cafe24/pgsql/data/logfile start`



## webdb 계정 연결

![1560132655749](assets/1560132655749.png)

![1560132684291](assets/1560132684291.png)

![1560132701119](assets/1560132701119.png)





## 접근못함 -> 소유주 권한

![1560132791715](assets/1560132791715.png)

아니면 접속할때

`psql -U postgres webdb`



## 테이블 소유자 변경

`alter table pet owner to webdb;`

![1560132990191](assets/1560132990191.png)

그냥 webdb로 들어가도 가능!

![1560133011776](assets/1560133011776.png)



## 데몬 설정

파일 가져오기(c드라이브에 파일 놓고)

![1560133351537](assets/1560133351537.png)

![1560133361852](assets/1560133361852.png)



`cp /home/webmaster/postgres /etc/init.d/`

`cd /etc/init.d/`

`chmod 755 postgres`

![1560133466077](assets/1560133466077.png)



`vi postgres`

> ![1560133583400](assets/1560133583400.png)



## stop

`/etc/init.d/postgres stop`

![1560133620091](assets/1560133620091.png)

`/etc/init.d/postgres start`



## chkconfig

`chkconfig --add postgres`

![1560133695931](assets/1560133695931.png)

`sync`

`reboot`

![1560133764090](assets/1560133764090.png)

**올라옴 ㅎㅎㅎ**



---



## 외부 연결

`vi /cafe24/pgsql/data/postgresql.conf `

> ![1560133904743](assets/1560133904743.png)



`vi /cafe24/pgsql/data/pg_hba.conf`

> ![1560134053975](assets/1560134053975.png)
>
> 
>
> ![1560134223958](assets/1560134223958.png)
>
> 이거랑 같은거임
>
> `create user 'webdb'@'192.168.1.0' <<<



서버 restart!!!!

`/etc/init.d/postgres stop`

`/etc/init.d/postgres start`



## tableplus 다운

<https://tableplus.io/windows>   64 bit

![1560134529875](assets/1560134529875.png)

###  방화벽 풀기

` vi /etc/sysconfig/iptables`

![1560134629462](assets/1560134629462.png)

`/etc/init.d/iptables stop`

`/etc/init.d/iptables start`



![1560134739281](assets/1560134739281.png)

![1560134767604](assets/1560134767604.png)



