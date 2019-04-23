### Xftp로 java download

원래는 tar파일 주소 복사해서 wget {{주소}} 해야하는데 oracle 아이디 필요하니까 일단 xftp로

일단 자바 파일을 다운로드!!!!! 

![1556003697413](assets/1556003697413.png)

![1556003717070](assets/1556003717070.png)

그럼 이렇게 들어옴!!!

`# tar xvfz jdk-8u211-linux-x64.tar.gz`    ===> 압축 풀기!!

![1556003967808](assets/1556003967808.png)

다운 완료 ^--^

---

`# vi /etc/profile` 

![1556007190096](assets/1556007190096.png)

directory 만들고 압축 풀기

![1556007402310](assets/1556007402310.png)

압축 해제!

![1556007539343](assets/1556007539343.png)

`./java`

`./java -version`

> ![1556007771598](assets/1556007771598.png)

update-alternatives --set java /usr/local/cafe24/jdk/jdk1.8.0_211/bin/java;

update-alternatives --set java /usr/local/cafe24/jdk/jdk1.8.0_211/bin/javac;

update-alternatives --set java /usr/local/cafe24/jdk/jdk1.8.0_211/bin/javws;

> ![1556007907801](assets/1556007907801.png)

---

##  Linux Java -> "Hello World" 출력

```shell
[root@localhost dowork]# cd java/
[root@localhost java]# ls
HelloWorld.class  HelloWorld.java
[root@localhost java]# vi Hello.java
[root@localhost java]# vi Hello.java
[root@localhost java]# javac Hello.java 
[root@localhost java]# java Hello
안녕!!
[root@localhost java]# 

```

**Hello.java**

```java
public class Hello{
        public static void main(String[] args){
                System.out.println("안녕!!");
        }
}
```



------

### wget으로 linux tomcat 다운

![1556002703627](assets/1556002703627.png)

링크 주소 복사!!!!!

`# wget http://apache.tt.co.kr/tomcat/tomcat-8/v8.5.40/bin/apache-tomcat-8.5.40.tar.gz`

![1556002740731](assets/1556002740731.png)

다운로드 끝!!

>  **Xftp로도 해봐야하니까 다시 지워야징** -> 원래! wget으로 하는게 맞는거임
>
> `# rm -f apache-tomcat-8.5.40.tar.gz `

---

### Xftp로 tomcat 다운

![1556002959965](assets/1556002959965.png)

​																			다운로드

​																				↓↓↓↓

![1556003006100](assets/1556003006100.png)



![1556003012914](assets/1556003012914.png)

local 파일 -> 옮기고

`tar xvfz apache.....`

------





