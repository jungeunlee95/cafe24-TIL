[TOC]

---



 ## spring custom annotation

**UserVo.java**

```java
@ValidGender
private String gender;
```



### 필요 package

com.cafe24.shoppingmall.dto

com.cafe24.shoppingmall.vo

com.cafe24.shoppingmall.validator

com.cafe24.shoppingmall.validator.constraints

![1563154713438](assets/1563154713438.png)

**ValidGender.java**

```java
import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

@Retention(RUNTIME)
@Target(FIELD)
@Constraint(validatedBy=GenderValidator.class)
public @interface ValidGender {
    String message() default "Invalid Gender";

    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
```



**GenderValidator.java**  -> ConstraintValidator<ValidGender.class, String>

```java
public class GenderValidator implements ConstraintValidator<ValidGender, String> {

    private Pattern pattern = Pattern.compile("MALE|FEMALE|NONE");


    @Override
    public void initialize(ValidGender constraintAnnotation) {
    }

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        if(value == null || value.length()==0 || "".contentEquals(value)) {
            return false;
        }

        return pattern.matcher( value ).matches();

    }

}
```





## login validation

login에서 발리데이션 제거

**UserController.java**

```java
@GetMapping(value="/login") 
public ResponseEntity<JSONResult> login(@RequestBody UserVo userVo) {

    Validator validator = Validation.buildDefaultValidatorFactory().getValidator();

    Set<ConstraintViolation<UserVo>> validatorResults = validator.validateProperty(userVo, "id");

    if(validatorResults.isEmpty() == false) {
        for( ConstraintViolation<UserVo> validatorResult : validatorResults ) {
            String message = validatorResult.getMessage();
            JSONResult result = JSONResult.fail(message);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(result);				
        }
    }

    Boolean exist = userService.getUser(userVo.getId(), userVo.getPassword());
    return ResponseEntity.status(HttpStatus.OK).body(JSONResult.success(exist));
} 
```

---

default message가져오기

```java
@Autowired
private MessageSource messageSource;

String message  = messageSource.getMessage("userVo.id", null, LocaleContextHolder.getLocale());
```

---



---

시나리오 한번에 테스트

src/test/java **com.cafe24.shoppingmall.senario/MemberOrderSenarioTest.java**

```java
@RunWith(Suite.class)
@SuiteClasses({
    UserControllerTest.class,
    MainControllerTest.class,
    ProductControllerTest.class,
    CartControllerTest.class
        })
public class MemberOrderSenarioTest {

    public static Test suite() {
        return new TestSuite("회원 주문 시나리오 테스트");
    }
}
```



























