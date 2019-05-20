**자바 설치 파일 가져와서 압축 푸는 것 부터**

```shell
   14  tar xvzf jdk-8u112-linux-x64.tar.gz
   15  ls
   16  tar xvzf jdk-8u211-linux-x64.tar.gz 
   17  ls
   18  mv jdk1.8.0_211/ /usr/local/cafe24/jdk1.8
   19  mv -p jdk1.8.0_211/ /usr/local/cafe24/jdk1.8
   20  cp jdk1.8.0_211/ /usr/local/cafe24/jdk1.8
   21  ls
   22  mkdir -p /usr/local/cafe24
   23  mv jdk1.8.0_211/ /usr/local/cafe24
   24  ls /usr/local/cafe24/
   25  vi /etc/profile
   26  cd /usr/local/cafe24/
   27  ls -la
   28  mv jdk1.8.0_211/ jdk1.8
   29  ls -la
   30  ln -s jdk1.8/ jdk
   31  ls -la
   32  history

```

```
#java
export JAVA_HOME=/usr/local/cafe24/jdk
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=.:$JAVA_HOME/lib/tools.jar
```



**톰캣**

```shell
   36  wget http://apache.tt.co.kr/tomcat/tomcat-8/v8.5.40/bin/apache-tomcat-8.5.40.tar.gz
   37  ls
   38  tar xvzf apache-tomcat-8.5.40.tar.gz 
   39  mv apache-tomcat-8.5.40 /usr/local/cafe24/tomcat8
   40  ls
   41  cd /usr/local/cafe24/
   42  ls -la
   43  ln -s tomcat8/ tomcat
   44  ls -l
   45  cd /usr/local/cafe24/tomcat
   46  ls -l
   47  cd conf/
   48  ls
   49  vi server.xml 
```

주소 확인 `vi server.xml` /8080검색

```
        <Connector port="8080" URIEncoding="UTF-8" protocol="HTTP/1.1" connectionTimeout="20000" redirectPort="8443" />
```



![1556094907402](assets/1556094907402.png)

8080 포트 추가!



`cd /usr/local/cafe24`

`/usr/local/cafe24/tomcat/bin/catalina.sh start`

`ps -ef | grep java`

> 성공! 
>
> ![1556095371379](assets/1556095371379.png)



**이클립스 설치 후 war파일 만들어서 배포 **

```
# vi /usr/local/cafe24/tomcat/conf/tomcat-users.xml
```

```
  <role rolename="manager"/>
  <role rolename="manager-gui" />
  <role rolename="manager-script" />
  <role rolename="manager-jmx" />
  <role rolename="manager-status" />
  <role rolename="admin"/>
  <user username="admin" password="manager" roles="admin,manager,manager-gui, manager-script, manager-jmx, manager-status"/>
  
  
  ## user안에 붙여넣기

```

```
# vi /usr/local/cafe24/tomcat/webapps/manager/META-INF/context.xml 

<Context privileged= "true" antiResourceLocking= "false" docBase= "${catalina.home}/webapps/manager">
	 <Valve className= "org.apache.catalina.valves.RemoteAddrValve" allow= "^.*$" /> 
</Context>

```

![1556098171662](assets/1556098171662.png)



**server restart**

```
# /usr/local/cafe24/tomcat/bin/catalina.sh stop
# /usr/local/cafe24/tomcat/bin/catalina.sh start
```



> > <http://192.168.1.50:8080/manager>

![1556098300623](assets/1556098300623.png)

**deloy 누르면 올라간 거 볼 수 있음**

![1556098487674](assets/1556098487674.png)



![1556099685865](assets/1556099685865.png)









