[TOC]



---

### *톰캣 띄우기  확인

![1558663880680](assets/1558663880680.png)

---

### *admin 계정 확인하기

```shell
[root@localhost conf]# cd /usr/local/cafe24/tomcat/conf/
[root@localhost conf]# cat tomcat-users.xml
```

![1558663955483](assets/1558663955483.png)

---

### *webdb 계정 권한

![1558664269121](assets/1558664269121.png)

### * 접속

`[root@localhost conf]# mysql -u webdb -D webdb -p`

> webdb 

![1558664456776](assets/1558664456776.png)

---

# CI - Jenkins

![1558665263704](assets/1558665263704.png)

[젠킨스](<https://victorydntmd.tistory.com/229>)

![1558665418300](assets/1558665418300.png)



## 리눅스에 Jenkins 설치

`wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war`

`mv jenkins.war /usr/local/cafe24/tomcat/webapps/`

> <http://192.168.1.52:8080/jenkins/>

![1558665896017](assets/1558665896017.png)

### **비밀번호 확인**

```
cd
ls -a
cd .jenkins/
cd secrets/
cat initialAdminPassword 
```

![1558666031314](assets/1558666031314.png)

![1558666298800](assets/1558666298800.png)

http://192.168.1.52:8080/jenkins/

![1558666351954](assets/1558666351954.png)




