[TOC]



---

# Object

## 1. ObjectTest01.java

### - getClass()

**reflection :  객체가 어떤 클래스로 생성됐는지**

```java
package object.text;
public class ObjectTest01 {
    public static void main(String[] args) {
        Point p = new Point(10, 20);

        System.out.println(p.getClass()); 
    }
}
```

> class object.text.Point



### - hashCode()

 **address 기반의 hashing값**

**: hashing?** = 알고리즘상 빨리 찾기 위해서 

> 매핑으로 변수에 저장되는 값은 reference값이 맞지만,
>
> 출력으로 보여주는 것은 reference값이 아닐거라고 추측한다! 
>
>  (물론 주소도 아닐듯) 

```java
System.out.println(p.hashCode());
```

> 366712642



### - toString()

**getClass() + "@" + hashCode()**

```java
		System.out.println(p);
		System.out.println(p.toString());
```

> println에 객체를 넣으면 자동으로 toString()을 불러옴

> object.text.Point@15db9742

---



---

## 2. ObjectTest02.java

### - ==

**두 객체의 동일성 비교 (같은 객체냐!)**

```java
package object.text;

public class ObjectTest02 {

	public static void main(String[] args) {
		Point p1 = new Point(10, 20);
		Point p2 = new Point(10, 20);
		Point p3 = p2;
		
		System.out.println(p1==p2);
		System.out.println(p2==p3);
	}
}
```

> ```
> false
> true
> ```



### - equals()

두 객체의 동질성을 비교한다. (내용 비교)

```java
	System.out.println(p1.equals(p2));
	System.out.println(p2.equals(p3));
```
> ```
> false
> true
> ```

​										뭐야! 다 같은데 왜 fasle나오는데?

![1557466155366](1557466155366.png)

​							equals의 원래 구현은 동일성(==) 과 **같게** 구현되어있어

​							그래서 오버라이드를 해줘야해 내용비교를 하고싶으면

**Point.java** -> alt+s 로 오버라이드 추가 

```java
...	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + x;
		result = prime * result + y;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Point other = (Point) obj;
		if (x != other.x)
			return false;
		if (y != other.y)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Point [x=" + x + ", y=" + y + "]";
	} // 내용기반으로 오버라이딩
```

> equals는 hashcode와 같이 오버라이드 해줘야 성능이 좋아짐
>
> -> 어떤 객체의 동질성을 비교할때는 항상 hashcode를 뽑아서 비교를함



### - String / hashCode()

```java
		// String
		String s1 = new String("ABC");
		String s2 = new String("ABC");
		System.out.println(s1 == s2);
		System.out.println(s1.equals(s2));
		System.out.println(s1.hashCode() + " : " + s2.hashCode());
        System.out.println(System.identityHashCode(s1) + " : " + System.identityHashCode(s2) );
```

> ```
> false
> true  
> 64578 : 64578
> 366712642 : 1829164700
> ```
>
> 다른 객체니까 동일성에선 false
>
> - identityHashCode : override되기 전 해시코드!

#### HashCode / identityHashCode

- HashCode는 내용기반
- identityHashCode 는 주소기반!



**근데** 

`String s = "ABC";` 이건 어떻게 가능해! 객체에 new를 안하고!!!!

```java
    String s3 = "ABC";
    String s4 = "ABC";

    System.out.println(s3 == s4);
    System.out.println(s3.equals(s4));
    System.out.println(s3.hashCode() + " : " + s4.hashCode());
    System.out.println(System.identityHashCode(s3) + " : " + System.identityHashCode(s4) );	
```

> ```
> true
> true
> 64578 : 64578
> 2018699554 : 2018699554
> ```
>
> 뭐야! 내부적으로 알아서 new 하고 만든다면,, 왜 이 값이 다 같은거야?
>
> --> String Constant Pool을 안거치기때문!!!
>
> ![1557468977429](assets/1557468977429.png)



---

## 3. ObjectTest03.java

### - HashSet

```java
package object.text;

import java.util.HashSet;
import java.util.Set;

public class ObjectTest03 {

	public static void main(String[] args) {
		Set<Point> set = new HashSet<Point>();
		
		Point p1 = new Point(10,20);
		set.add(p1);
		
		Point p2 = new Point(100,200);
		set.add(p2);
		
		Point p3 = p1;
		set.add(p3);
		
		for(Point p : set) {
			System.out.println(p);
		}
	}
}
```

> ```
> Point [x=100, y=200]
> Point [x=10, y=20]
> ```

만약 Point의 HashCode() 메소드를 지우고 실행하면?

> ```
> Point [x=100, y=200]
> Point [x=10, y=20]
> Point [x=10, y=20]
> 
> ```
>
> 3개가 들어감!

---



























