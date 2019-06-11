[TOC]

---

migration

mysql(hr) -> postgresql(hr)  : **pgloader(migration 툴)**

postgresql -> mysql

---

spring betch

---



**pgloader**

> <https://github.com/dimitri/pgloader>



위에꺼 연습으로 해보기

---



---

# postgresql



## 사용자 hr 생성

```
create user hr with password 'hr';
```



## db hr 생성

```
create database hr;
```



## 권한

```
grant all privileges on all tables in schema public to hr;
```



## 접속 설정

`vi /cafe24/pgsql/data/pg_hba.conf `

![1560213365180](assets/1560213365180.png)

![1560213400255](assets/1560213400255.png)

`/etc/init.d/postgres stop`

`/etc/init.d/postgres start`



## dump data 가져오기

1. **자료 dump data 직접 넣기**

   > ![1560214140074](assets/1560214140074.png)



2. **깃에서 가져오기**

`git clone <https://github.com/jungeunlee95/pgsql-sample-data`>

![1560213709970](assets/1560213709970.png)

![1560213826978](assets/1560213826978.png)

` psql -U hr -f employees.dump hr`

![1560213942069](assets/1560213942069.png)

**dump 데이터 확인 !** 

![1560214100340](assets/1560214100340.png)





## dbeaver 다운

<https://dbeaver.io/download/>

- [Windows 64 bit (zip archive)](https://dbeaver.io/files/dbeaver-ce-latest-win32.win32.x86_64.zip) 다운

![1560214249050](assets/1560214249050.png)

![1560214341388](assets/1560214341388.png)

Add File

![1560214366963](assets/1560214366963.png)

![1560214396585](assets/1560214396585.png)

![1560214405992](assets/1560214405992.png)



