[TOC]

---

# 설정

![1558670754571](assets/1558670754571.png)

## Global Tool Configuration 설정

![1558670763036](assets/1558670763036.png)

![1558670840064](assets/1558670840064.png)



![1558670945283](assets/1558670945283.png)

![1558671010942](assets/1558671010942.png)

---

## New item

![1558671063168](assets/1558671063168.png)

![1558671145807](assets/1558671145807.png)

![1558671317613](assets/1558671317613.png)

`clean package tomcat:redeploy -Pproduction -Dmaven.test.skip=true`

---



---

# Build Now

## mvn error :eight_pointed_black_star:

![1558671396101](assets/1558671396101.png)

> path 추가해줘야해
>
> `vi /etc/init.d/tomcat`
>
> ![1558671600394](assets/1558671600394.png)
>
> `[root@localhost ~]# /etc/init.d/tomcat stop`
>
> `[root@localhost ~]# /etc/init.d/tomcat start`

---

## 다시 빌드

![1558671710218](assets/1558671710218.png)

![1558671724113](assets/1558671724113.png)

**다시 build now**

## Compile Error :eight_pointed_black_star:

![1558671815518](assets/1558671815518.png)

![1558671827358](assets/1558671827358.png)

> 리눅스에서 마이사이트
>
> ```shell
> cd
> cd .jenkins/
> ls
> ls -la
> cd workspace/
> ls -la
> cd mysite2/
> ```
> 
>톰캣 라이브러리들이 없는 것 같음
> 
>![1558671992612](assets/1558671992612.png)
> 
>Apache라이브러리를 Maven으로 옮겨줘야해



##  mysite/pom.xml에 Profiles추가

```xml
<profiles>
    <profile>
        <id>production</id>
        <build>
            <resources>
                <resource>
                    <directory>${project.basedir}/src/main/resources</directory>
                    <excludes>
                        <exclude>**/*.java</exclude>
                    </excludes>
                </resource>
            </resources>
            <plugins>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-resources-plugin</artifactId>
                    <configuration>
                        <encoding>UTF-8</encoding>
                    </configuration>
                </plugin>
            </plugins>
        </build>
        <dependencies>
            <!-- Servlet -->
            <dependency>
                <groupId>javax.servlet</groupId>
                <artifactId>javax.servlet-api</artifactId>
                <version>3.0.1</version>
                <scope>provided</scope>
            </dependency>
            <dependency>
                <groupId>javax.servlet.jsp</groupId>
                <artifactId>jsp-api</artifactId>
                <version>2.0</version>
                <scope>provided</scope>
            </dependency>
        </dependencies>
    </profile>
</profiles>
```

> mvn실행할때 -Pproduction 했던 명령어가 적용되는거야
>
> git push후 다시 Build

![1558672273911](assets/1558672273911.png)

> **라이브러리 다운중~**





## Compile Error :eight_pointed_black_star:

![1558672369516](assets/1558672369516.png)

**plugin 추가**

```xml
			<plugin>
				<groupId>org.codehaus.mojo</groupId>
				<artifactId>tomcat-maven-plugin</artifactId>
				<configuration>
					<url>http://127.0.0.1/manager/text</url>
					<path>/mysite3</path>
					<username>admin</username>
					<password>manager</password>
				</configuration>
			</plugin>

```

![1558678591375](assets/1558678591375.png)

다시 빌드!!!!!!!



## port 번호 error ! :eight_pointed_black_star:

![1558672496847](assets/1558672496847.png)

**8080추가**

![1558672519128](assets/1558672519128.png)

 다시 빌드!!!



## 빌드 성공 !! :blue_heart:

![1558672687222](assets/1558672687222.png)



## db서버 변경

![1558672845169](assets/1558672845169.png)



이렇게 하면 

![1558674527640](assets/1558674527640.png)
