[TOC]

---

# 들어가기 전 ..

## java SE, java EE

**Java SE (JDK-javac + JRE-java  = Java API)**  

**Java EE[^Enterprise Edition]**  웹 어플리케이션

>  Enterprise ? naver, 옥션, 병원 등... 에서 만드는 프로그램들 => 비즈니스 서비스들 
>
> - 특히 기업들이 만드는 서비스들 (상업용)
> - 자바 기반으로 웹 프로그래밍을 할수있게 웹 프로그래밍 스펙을 만들어야겠다!
> - web 기반(client/server) ==> Servlet/JSP
> - RDBMS에 data CRUD할수있는 ==> JDBC Programming
> - RMI
> - JMS
> - JNDI
>
> JavaEE가 돌려면 JavaSE가 밑에서 돌아야함 -> 둘이 별개가 아님

java(JVM)이 제일 밑에 깔려있고, 우리가 만든 어플리케이션들은 모두 이 위에서 돔

---



---

## web application - was

java(jar)는 runtime이 **JVM[^Java Virtual Machine]**

web application(war)는 runtime이 필요해 --> **WAS[^web application server]** : tomcat

> M에 WAS가 뜨면, 자신에 저 웹 어플리케이션들을 등록함

> wep app는 web.xml을 갖고있음 --> 여기서 뭐 실행시키고 이런 설정..

---

**web app의 구성**

요청이 들어오면, 톰캣이 요청을 받음. 

톰캣이 관리하는 프로그램이 하나가 아니라면,

어떤 웹 어플리케이션으로 가야하는지 지정을 해야함 (context path - process구조(문맥))

> 예를들어 mysite app과 bookmall app이 있으면, url에 /mysite/user 이렇게 요청이 오면
>
> tomcat이 mysite어플리케이션의 /user로 mapping된 서블릿을 찾아 객체로 만들어 거기로 보냄!

> listener
>
> filter
>
> servlet(JSP)
>
> 위의 세가지를 web.xml에 해놓으면 됨

---

/mysite/user

첫번째 request가 들어오면 thread1이 실행됨

어플리케이션을 찾고, class path에서  찾으면

 `HttpServlet s = new userServlet();` s가 get post인지 찾고

`s.doGet(HttpServletRequest, HttpServletResponse)` 

​	 HttpServletRequest : 파라미터 등 정보를 이 객체에 다 담음

​	 HttpServletResponse : I/O Stream

---

**DAO**

Servlet => 요청과 응답을 해주는 애

doGet(){ 

}  -> 이 메소드 안에 DAO < --- CRUD ---- > DB 가 있겠찌? 톰캣은 여기 상관 안함

프로젝트가 커질수록 수많은 DAO, VO가 생기는데 이것들도 서로 막 엮여있음

얘네(business 객체들)도 관리를 해주자!  --- 그래서 나온게 ---> EJB

---

business 객체(Enterprise ) == Bean은 같은 의미  === > Enterprise Java Bean[**EJB**]

**EJB** -> WAS에 포함된 기능

이제 web app들이 모두 EJB 컨테이너 안에 들어와서 관리를 받게 됨

이제 doget에서 dao부르면 EJB안에서 비즈니스들(DAO-DB)이 일어남

요청을 처리해서 response를 하나의 쓰레드에서 하는 것!

---

servlet은 톰캣이라는 기술에 묶여있어(톰캣이 없으면 실행할수X) - 톰캣 메소드 상속받으니까

**EJB Container의 단점**은 EJB의 관리를 받으려면 우리의 비지니스 객체들이 EJB 컨테이너에 묶이게 되는거야 (DAO에 EJB클래스 상속받고 뭐 뭐뭠 구현해야할 메소드가 장난아님.) 설정도 복잡해지고 ... EJB hell.. 유지보수는 무슨 런칭도 힘듦--> 객체지향을 너무 테크닉하게 씀 

---

**Spring Container**

Spring안에 객체들이 그대로 다 들어가는데 ! POJO[^Plain Old Java Object] : simple

복잡한 상속 구현 없이 컨테이너안에서 비즈니스 객체를 관리해줌 (의존성 주입 등)

> 비즈니스에 집중해서 잘 구현하고 유지보수를 잘 할지. 구조들을 잘 파악하는 것이 중요.