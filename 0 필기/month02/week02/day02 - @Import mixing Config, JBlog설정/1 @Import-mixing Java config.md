[TOC]



---



## mixing config

### config.videosystem/DVDPlayerConfig 나누기 

->**config.videosystem.mixing패키지** L   DVDConfig, DVDPlayerConfig

**DVDConfig.java**

```java
@Configuration
public class DVDConfig {

    @Bean // 명시적
    public Avengers avengers(){
        return new Avengers();
    }

    @Bean(name="avengersInfinityWar")
    public BlankDisc blankDisc() {
        BlankDisc blankDisc = new BlankDisc();
        blankDisc.setTitle("Avengers Infinity War");
        blankDisc.setStudio("MARVEL");
        return blankDisc;
    }
}
```

**DVDPlayer02Config.java**

```java
@Configuration
public class DVDPlayerConfig {
	@Bean
	public DVDPlayer dvdPlayer(@Qualifier("avengersInfinityWar") DigitalVideoDisc dvd) {
		return new DVDPlayer(dvd);
	}
}
```

---

### **TEST 01 **- DVDPlayerMixingConfigTest01

com.cafe24.springcontainer.videosystem/**DVDPlayerMixingConfigTest01**

**DVDPlayerMixingConfigTest01.java**

```java
import config.videosystem.mixing.DVDPlayerConfig;
/*
 * 명시적(Explicit) Configuration - Java Mixing Config Test
 * Java Config <----- (JavaConfig1,JavaConfig2, JavaConfig3) 
 * 			   @Import
 * 자바 컨피그에 자바 컨피그를 줌
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes=DVDPlayerConfig.class)
public class DVDPlayerMixingConfigTest01 {
	@Rule
	public final SystemOutRule systemOutRule = new SystemOutRule().enableLog();

	@Autowired
	private DVDPlayer player;
	
    @Test
	public void testPlayerNull() {
		assertNotNull(player);
	}
}
```

> ERROR
>
> **DVDPlayerConfig.java** `@Import(DVDConfig.class)` 추가
>
> ```java
> @Configuration
> @Import(DVDConfig.class)
> public class DVDPlayerConfig {
> 	@Bean
> 	public DVDPlayer dvdPlayer(@Qualifier("avengersInfinityWar") DigitalVideoDisc dvd) {
> 		return new DVDPlayer(dvd);
> 	}
> }
> ```

---





---

### **TEST 02** - DVDPlayerMixingConfigTest02

**VideoSystemConfig.java** ![1559004426837](assets/1559004426837.png)

```java
@Configuration
@Import({DVDConfig.class, DVDPlayerConfig.class})
public class VideoSystemConfig {

}
```

TEST - **DVDPlayerMixingConfigTest02.java**

```java
/*
 * 명시적(Explicit) Configuration - Java Mixing Config Test
 * Java Config <----- (JavaConfig1,JavaConfig2, JavaConfig3) 
 * 			   @Import
 * 자바 컨피그에 자바 컨피그를 줌
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes=VideoSystemConfig.class)
public class DVDPlayerMixingConfigTest02 {
	@Rule
	public final SystemOutRule systemOutRule = new SystemOutRule().enableLog();

	@Autowired
	private DVDPlayer player;
	
	@Test
	public void testDVDNull() {
		assertNotNull(player);
	}
}
```



