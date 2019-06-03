[TOC]

---

## mysite2  빌드

![1559526524823](assets/1559526524823.png)

> 아직 80 manager를 안달아줌!

## mysite2 pom.xml -> port 변경

```xml
	<modelVersion>4.0.0</modelVersion>
	<artifactId>springboot-mysite</artifactId>
	<packaging>war</packaging> 

---
---

<plugin>
    <groupId>org.codehaus.mojo</groupId>
    <artifactId>tomcat-maven-plugin</artifactId>
    <configuration>
        <url>http://127.0.0.1:8080/manager/text</url>
        <path>/mysite2</path>
        <username>admin</username>
        <password>manager</password>
    </configuration>
</plugin>
```

> ![1559526591192](assets/1559526591192.png)

---





---

# spring boot - multi project

## Mysite Tomcat 배포 구성

springboot- mysite : **pom.xml** ![1559527913899](assets/1559527913899.png)

```xml
	<build>
		<finalName>${artifactId}</finalName>
		<plugins>
			<plugin>
				<artifactId>maven-war-plugin</artifactId>
				<configuration>
					<warSourceDirectory>src/main/webapp</warSourceDirectory>
				</configuration>
			</plugin>
			<plugin>
				<groupId>org.codehaus.mojo</groupId>
				<artifactId>tomcat-maven-plugin</artifactId>
				<configuration>
					<url>http://127.0.0.1:8080/manager/text</url>
					<path>/mysite5</path>
					<username>admin</username>
					<password>manager</password>
				</configuration>
			</plugin>
		</plugins>
	</build>
```



**BootInitializer.java**  ![1559528418435](assets/1559528418435.png)

```java
@EnableAutoConfiguration
public class BootInitializer extends SpringBootServletInitializer {
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(BootApp.class);
	}
}
```

---



---

## Jenkins 배포

![1559528705344](assets/1559528705344.png)

![1559528774733](assets/1559528774733.png)

![1559528780579](assets/1559528780579.png)

---



---

## Build Now

![1559533337597](assets/1559533337597.png)

### :x: error!!!!  -> `tail -f catalina.out`

![1559535341508](assets/1559535341508.png)

`tail -f catalina.out`



**새창**

![1559535560209](assets/1559535560209.png)

`/usr/lcoal/cafe24/maven/bin/mvn mvn clean package tomcat:redeploy -Pproduction -Dmaven.test.skip=true`



![1559535626719](assets/1559535626719.png)

> application이 뜨면서 error가 생김!!!! listerners의 문제!!!!!!!
>
> springboot-mysite 의 web.xml을 지워버려!!!!!!!!!!!!
>
> ![1559535750199](assets/1559535750199.png)

---

빠른확인!!!

`cd /cafe24/tomcat-cafe24/webapps/`

![1559535873657](assets/1559535873657.png)

`/etc/init.d/tomcat-cafe24 stop`

`/etc/init.d/tomcat-cafe24 start`



### :star: ​error 해결

![1559535985323](assets/1559535985323.png)

---



---

## Jenkins Build Now 다시

![1559536143456](assets/1559536143456.png)

![1559536152871](assets/1559536152871.png)



