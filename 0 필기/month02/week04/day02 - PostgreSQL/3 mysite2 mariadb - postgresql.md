[TOC]



---

mysite -> postgresql

![1560228582815](assets/1560228582815.png)

![1560229470085](assets/1560229470085.png)

**pom.xml**

```xml
<!-- postgresql jdbc driver -->
<dependency>
    <groupId>org.postgresql</groupId>
    <artifactId>postgresql</artifactId>
    <version>42.2.5</version>
</dependency>
```

**applicationContext.xml**

```xml
<!-- Connection Pool DataSource -->
<bean id="dataSource"
      class="org.apache.commons.dbcp.BasicDataSource">
    <property name="driverClassName" value="org.postgresql.Driver" />
    <property name="url" value="jdbc:postgresql://192.168.1.52:5432/webdb" />
    <property name="username" value="webdb" />
    <property name="password" value="webdb" />
</bean>
```



**개발용, 배포용 mapper 수정**

![1560231768513](assets/1560231768513.png)

---

![1560234703465](assets/1560234703465.png)

![1560234721843](assets/1560234721843.png)

![1560234740024](assets/1560234740024.png)

---



# 폴더구조 다시 바꿈 :star:

![1560246695114](assets/1560246695114.png)

---

**바로 pk 가져와야할때**

```xml
<insert id="insert" parameterType="uservo">
    <![CDATA[
  insert into users
  values(default, #{name }, #{email }, #{password }, #{gender }, 'USER', now())
 ]]>
    <selectKey keyProperty="no" resultType="long" order="AFTER">
        <![CDATA[
  select max(no) from users
 ]]>
    </selectKey>
</insert> 
```

```XML
<insert id="insert" parameterType="uservo">
    <![CDATA[
  insert into users
  values(#{no }, #{name }, #{email }, #{password }, #{gender }, 'USER', now())
 ]]>
    <selectKey keyProperty="no" resultType="long" order="BEFORE">
        <![CDATA[
  select nextval('seq_member')
 ]]>
    </selectKey>
</insert> 
```















