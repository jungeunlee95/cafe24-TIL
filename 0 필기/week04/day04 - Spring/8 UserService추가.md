[TOC]

---

# Service

## UserService

com.cafe24.mysite.service

**UserService.java**

```java
	@Autowired
	private UserDao userDao;

	public Boolean join(UserVo userVo) {
		return userDao.insert(userVo);
	}
```

**UserController.java**

```java
	@Autowired
	private UserService userService;

	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String join(@ModelAttribute UserVo userVo) {
		//userDao.insert(userVo);
		userService.join(userVo);
		return "redirect:/user/joinsuccess";
	}
```

**UserVo 생성자 만들기**

```java
	public UserVo(String email, String password) {
		this.email = email;
		this.password = password;
	}
```

**UserController.java**

```java
		//UserVo authUser = userDao.get(email,password); 
		UserVo userVo = new UserVo(email,password);
		UserVo authUser = userService.getUser(userVo); 
```

**UserService.java**

```java
	public UserVo getUser(UserVo userVo) {
		return userDao.get(userVo); 
	}
```

**UserDao.java**

```java
public UserVo get(UserVo userVo) {			
    pstmt.setString(1, userVo.getEmail());
    pstmt.setString(2, userVo.getPassword());
}
```



**applicationContext.xml**

```xml
<context:component-scan base-package="com.cafe24.mysite.repository, com.cafe24.mysite.service">
```