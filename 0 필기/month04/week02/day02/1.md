[TOC]

---

# oauth

## **get 방식**

**ControllerTest.java**

### 1 토큰 만들기

```java
private String getAccessToken(String username, String password) throws Exception{

    MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
    params.add("grant_type", "password");
    params.add("client_id", "pjmall");
    params.add("username", username);
    params.add("password", password);
    params.add("scope", "read");
    // params.add("scope", "MALL_USER"); 
    // -> 이런식으로 영역지정할수있음(관리자, 회원)
    // ResourceServerConfig.java에서 http configure에도 영역을
    // .access("#oauth2.hasScope('MAll_USER')");

    ResultActions resultActions =
        mockMvc
        .perform(post("/oauth/token")
                 .params(params)
                 .with(httpBasic("pjmall","1234"))		
                 .contentType(MediaType.APPLICATION_JSON))
        .andDo(print())
        .andExpect(status().isOk());

    return "";
}
```

> ```
> MockHttpServletResponse:
> Status = 200
> Error message = null
> Headers = {Cache-Control=[no-store], Pragma=[no-cache], Content-Type=[application/json;charset=UTF-8], X-Content-Type-Options=[nosniff], X-XSS-Protection=[1; mode=block], X-Frame-Options=[DENY]}
> Content type = application/json;charset=UTF-8
> Body = {"access_token":"15154d58-68e1-4a7a-aee0-6f0d4138e5cd","token_type":"bearer","refresh_token":"98f606ef-3e7b-46fe-b543-6fdac92d0a48","expires_in":43199,"scope":"read"}
> Forwarded URL = null
> Redirected URL = null
> Cookies = []
> ```
>
> : 여기서 Body의 access_token을 뺴와야함!

```java
private String getAccessToken(String username, String password) throws Exception{

    MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
    params.add("grant_type", "password");
    params.add("client_id", "pjmall");
    params.add("username", username);
    params.add("password", password);
    params.add("scope", "MALL_USER");

    ResultActions resultActions =
        mockMvc
        .perform(post("/oauth/token")
                 .params(params)
                 .with(httpBasic("pjmall","1234"))		
                 .contentType(MediaType.APPLICATION_JSON))
        .andDo(print())
        .andExpect(status().isOk());

    String resultString = resultActions.andReturn().getResponse().getContentAsString();

    JacksonJsonParser jsonParser = new JacksonJsonParser();
    String accessToken = jsonParser.parseMap(resultString).get("access_token").toString();

    return accessToken;
}
```

<br>

### 2 토큰 받기

```java
@Test
public void testHelloAuthorized() throws Exception{
    String accessToken = getAccessToken("test", "1234");

    mockMvc
        .perform(
        get("/hello")
        .header("Authorization", "Bearer " + accessToken))
        .andDo(print())
        .andExpect(status().isOk());		 
}
```

> ```
> MockHttpServletResponse:
> Status = 200
> Error message = null
> Headers = {Cache-Control=[no-store], Pragma=[no-cache], Content-Type=[application/json;charset=UTF-8], X-Content-Type-Options=[nosniff], X-XSS-Protection=[1; mode=block], X-Frame-Options=[DENY]}
> Content type = application/json;charset=UTF-8
> Body = {"access_token":"08ed0394-fd08-44ad-a2c1-e46dc77ef8c8","token_type":"bearer","refresh_token":"eed37483-0c6b-4c4a-8289-552514d6ecd6","expires_in":43199,"scope":"read"}
> Forwarded URL = null
> Redirected URL = null
> Cookies = []
> ```

<br>

### 3 토큰 변수 유지

```java
private String accessToken;

@Before
public void setUp() throws Exception {
    mockMvc = MockMvcBuilders
        .webAppContextSetup(webApplicationContext)
        .addFilter(springSecurityFilterChain)
        .build();

    if(accessToken != null) {
        return;
    }
    MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
    params.add("grant_type", "password");
    params.add("client_id", "pjmall");
    params.add("username", "test");
    params.add("password", "1234");
    params.add("scope", "MALL_USER");

    ResultActions resultActions =
        mockMvc
        .perform(post("/oauth/token")
                 .params(params)
                 .with(httpBasic("pjmall","1234"))		
                 .contentType(MediaType.APPLICATION_JSON))
        .andDo(print())
        .andExpect(status().isOk());

    String resultString = resultActions.andReturn().getResponse().getContentAsString();

    JacksonJsonParser jsonParser = new JacksonJsonParser();
    accessToken = jsonParser.parseMap(resultString).get("access_token").toString();
}

@Test
public void testHelloAuthorized() throws Exception{
    //		String accessToken = getAccessToken("test", "1234");

    mockMvc
        .perform(
        get("/hello")
        .header("Authorization", "Bearer " + accessToken)
    )
        .andDo(print())
        .andExpect(status().isOk());		 
}
```

---



---

## **post 방식** 

**User 만들기** ![1563845778383](assets/1563845778383.png)

```java
private Long no;
private String email;
private String password;
```



**HelloController.java 추가**

```java
@PostMapping("/hello2")
public ResponseEntity<JSONResult> hello2(@RequestBody User user){
    return ResponseEntity
        .status(HttpStatus.OK)
        .body(JSONResult.success("Hello World2"));
}
```



**ControllerTest.java**

```java
@Test
public void testPostAuthorized() throws Exception{

    User user = new User(1L, "leeap1004@gmail.com", "Hello123");

    mockMvc
        .perform(
        post("/hello2")
        .header("Authorization", "Bearer " + accessToken)
        .contentType(MediaType.APPLICATION_JSON)
        .content(new Gson().toJson(user))
    )
        .andDo(print())
        .andExpect(status().isOk());		 
}
```

---



---

## RestTemplate

> Service에 주입해서 쓰삼









































