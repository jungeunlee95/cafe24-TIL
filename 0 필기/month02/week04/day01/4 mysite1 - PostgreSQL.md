[TOC]



---

**pom.xml**  <https://mvnrepository.com/artifact/org.postgresql/postgresql/42.2.5>

```xml
<!-- postgresql jdbc driver -->
<dependency>
    <groupId>org.postgresql</groupId>
    <artifactId>postgresql</artifactId>
    <version>42.2.5</version>
</dependency>
```

---

![1560143509568](assets/1560143509568.png)

![1560143670790](assets/1560143670790.png)

포워드 엔지니어링

---

DAO에 Connection 수정

```java
private Connection getConnection() throws SQLException {
    Connection conn = null;
    try {
        Class.forName("org.postgresql.Driver");
        String url = "jdbc:postgresql://192.168.1.52:5432/webdb";
        conn = DriverManager.getConnection(url, "webdb", "webdb");
    } catch (ClassNotFoundException e) {
        System.out.println("드라이버 로딩 실패");
    } finally {

    }
    return conn;
}
```

null -> defalut

> ![1560144416781](assets/1560144416781.png)

date_format -> to_char

> ![1560144402429](assets/1560144402429.png)

---



---

**user table error**

테이블  user -> member 로 수정



![1560144659326](assets/1560144659326.png)

![1560144624260](assets/1560144624260.png)

