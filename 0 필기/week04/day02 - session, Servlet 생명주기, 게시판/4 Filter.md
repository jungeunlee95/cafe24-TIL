---

###  코드 : [Servlet-Basic](https://github.com/jungeunlee95/Servlet-Basic)

`request.setCharacterEncoding("utf-8");`

필터에서 처리시키고 모든 서블릿으로 ! 

new package ==> com.cafe24.web.filter

![1557815795589](assets/1557815795589.png)

![1557815826305](assets/1557815826305.png)

-> /* 로 !!!

**EncodingFilter.java**

```java
package com.cafe24.web.filter;
@WebFilter("/*")
public class EncodingFilter implements Filter {

    public void init(FilterConfig fConfig) throws ServletException {
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        /* request 처리 */
        request.setCharacterEncoding("utf-8");

        chain.doFilter(request, response);

        /* response 처리 */
    }
    
    public void destroy() {
    }
}
```



filter에 파라미터 

**web.xml**  -> 이거 설정하면 EncodingFilter.java에서 @WebFilter("/*") 지워야함

```xml
	<!-- encoding filter -->	
	<filter>
		<filter-name>EncodingFilter</filter-name>
		<filter-class>com.cafe24.web.filter.EncodingFilter</filter-class>
		<init-param>
			<param-name>encoding</param-name>
			<param-value>utf-8</param-value>
		</init-param>
	</filter>
	<filter-mapping>
		<filter-name>EncodingFilter</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>
```

> 		<init-param>
> 			<param-name>encoding</param-name>
> 			<param-value>utf-8</param-value>
> 		</init-param>
> 이 부분으로 어떤 인코딩할지 파라미터로 보냄



**EncodingFilter.java**

```java
package com.cafe24.web.filter;

public class EncodingFilter implements Filter {

	private String encoding;
	
	public void init(FilterConfig fConfig) throws ServletException {
		System.out.println("Encoding Filter Initialized...");
		encoding = fConfig.getInitParameter("encoding");
		if(encoding == null) {
			encoding = "utf-8";
		}
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		/* request 처리 */
//		request.setCharacterEncoding("utf-8");
		request.setCharacterEncoding(encoding);
		
		chain.doFilter(request, response);
		
		/* response 처리 */
	}
    
	public void destroy() {	
        
	}
}
```

![1557816650288](assets/1557816650288.png)











































