[TOC]

---

< 자바의 맥락 >

기본프로그래밍

객체지향개념

객체지향 프로그래밍

Java API

Thread / network programming

servlet / jsp

spring mvc



---

기본프로그래밍

변수 = 저장공간의 심볼임(메모리주소)

uml 자바 책, cbd 책 추천



---

# Swap Test

**java-oop/src/swap/Value.java**

```java
package swap;
public class Value {
	public int val;
    
	public void val(int val) {
		this.val = val;
	}
}
```



**java-oop/src/swap/SwapTest.java**

```java
package swap;

public class SwapTest {

	public static void main(String[] args) {
		int a = 10;
		int b = 20;
		
		System.out.println(a + ": " + b);
		swap(a, b);
		System.out.println(a + ": " + b);
		
		
		Value v1 = new Value();
		v1.val = 10;
		
		Value v2 = new Value();
		v2.val = 20;
		
		System.out.println(v1.val + " : " + v2.val);
		swap(v1, v2);
		System.out.println(v1.val + " : " + v2.val);
	
	}

	private static void swap(Value m, Value n) {
		int temp = m.val;
		m.val = n.val;
		n.val = temp;
	}
	
	private static void swap(int m, int n) {
		int temp = m;
		m = n;
		n = temp;
	}
}

```

> ```출력
> 10: 20
> 10: 20
> 10 : 20
> 20 : 10
> ```

int를 보낼경우, stack영역에 각각의 다른 변수가 생김!

Value같은 경우는 객체를 묶어서 주소값을 보내기때문에

같은 주소를 가리키며, 그 주소의 객체안의 값을 변경시키기에 가능함!

---



# 자바 OOP 연습

## 간단한 그림판

### 1. 간단한 좌표에 점 찍기!

**paint/Point.java**

```java
package paint;
public class Point {
	private int x;
	private int y;
	
    public Point() {
		super();
	} // 기본 생성자를 만들어야함!
    
	public Point(int x, int y) {
		this.x = x;
		this.y = y;		
	}
	public void show() {
		System.out.println("점 ( " + this.x + ", " + this.y + ")에 점을 찍었습니다.");
	}
	
}
```



**paint/MainApp.java**

```java
package paint;

public class MainApp {

	public static void main(String[] args) {
		Point p1 = new Point(10, 20);
		drawPoint(p1);
	}
	
	public static void drawPoint(Point point) {
		point.show();
	}
}
```

> ```출력
> 점 ( 10, 20)에 점을 찍었습니다.
> ```



### 2. 색이 있는 점

> Point 점을 상속받은 ColorPoint를 만든다!
>
> ![1557455929088](assets/1557455929088.png)



**Point.java**  >> getter, setter를 만드는게 좋지만 연습이니까 그냥 protected!

```java
	protected int x;
	protected int y;
```

**paint**/**ColorPoint.java**

```java
public class ColorPoint extends Point {
	private String color;
    
	public ColorPoint(int x, int y, String color) {
		super(x, y);  // 부모에 기본 생성자가 없을경우, 거기 있는 생성자에 맞춰 넣으면 됨
		this.color = color;
	}
    
    @Override
	public void show() {
		System.out.println("좌표 ( " + this.x + ", " + this.y + ")에 "+ this.color +"점을 찍었습니다.");
	}
}
```

**Point.java**  >> getter, setter를 만드는게 좋지만 연습이니까 그냥 protected!

```java
	protected int x;
	protected int y;
```



**MaintApp.java**

```java
package paint;
public class MainApp {

	public static void main(String[] args) {
		Point p1 = new Point(10, 20);
		// 점찍기
		drawPoint(p1);
		
		ColorPoint p2 = new ColorPoint(50,  100,  "red");
		drawPoint(p2);
	}
	
	public static void drawPoint(Point point) {
		point.show();
	}
	
	public static void drawPoint(ColorPoint colorPoint) {
		colorPoint.show();
	}
}
```

> ```출력
> 좌표 ( 10, 20)에 점을 찍었습니다.
> 좌표 ( 50, 100)에 red점을 찍었습니다.
> ```

**근데 여기서 문제!!**

`ColorPoint p2 = new ColorPoint(50,  100,  "red");` 에서 부모로 받으면 좋잖아??

> `Point p2 = new ColorPoint(50,  100,  "red");`

그럼 Main에서 drawPoint()메소드 오버로딩 할 필요 없음!

**MainApp.java**

```java
package paint;
public class MainApp {
    
	public static void main(String[] args) {
		Point p1 = new Point(10, 20);
		// 점찍기
		drawPoint(p1);
		
		Point p2 = new ColorPoint(50,  100,  "red");
		drawPoint(p2);
	}
	
	public static void drawPoint(Point point) {
		point.show();
	}

}
```

---



### 3. 점 지우기

**Point.java**

```java
public void show(boolean visible) {
    if(visible) {			
        System.out.println("좌표 (" + this.x + ", " + this.y + ")에 점을 찍었습니다.");
    }else {
        System.out.println("좌표 (" + this.x + ", " + this.y + ")에 점을 지웠습니다.");
    }
}
```

**MainApp.java**

```java
		p1.show(false);
		p2.show(false);
```



`p2.show(true);` 를 부르면 색깔점이 안찍히고 그냥 점만 찍힘

--> **ColorPoint.java** 에서도 오버라이드 해야함!

**Point.java** 에서 오버라이드를 이미 한 show() 메소드를 재사용하면 됨!!

```java
public void show(boolean visible) {
    if(visible) {			
//System.out.println("좌표 (" + this.x + ", " + this.y + ")에 점을 찍었습니다.");
        show();
        return;
    }
    System.out.println("좌표 (" + this.x + ", " + this.y + ")에 점을 지웠습니다.");
}
```

---



### 4. 도형 그리기

#### - 삼각형

이제부턴 좌표(데이터) 신경 안쓰고 확인만 하겠음

**Triangle.java**

```java
package paint;
public class Triangle {
	private int x1;
	private int x2;
	private int x3;
	private int y1;
	private int y2;
	private int y3;
	
	private String fillColor;
	private String lineColor;
	
	public void draw() {
		System.out.println("삼각형을 그렸습니다.");
	}
}
```

**MainApp.java**

```java
		Triangle triangle = new Triangle();
		drawTriangle(triangle);
```

```java
	public static void drawTriangle(Triangle triangle) {
		triangle.draw();
	}
```



**근데! 삼각형만 만들거야?**

**사각형, 오각형 .. 등 도형은 계속 생기잖아**

**도형을 추상클래스를 올리면 어떨까?**



#### - 사각형

**Shape.java**

```java
package paint;

public abstract class Shape {
	
	private String fillColor;
	private String lineColor;
	
	public abstract void draw();
	
}
```

> 현재 어떤 도형을 그릴지 아직 몰라, 구현은 자식에게 맡긴다!

**Triangle.java**

```java
package paint;
public class Triangle extends Shape {
	private int x1;
	private int x2;
	private int x3;
	private int y1;
	private int y2;
	private int y3;
	
	@Override
	public void draw() {
		System.out.println("삼각형을 그렸습니다.");
	}
}
```

**Rect.java**

```java
package paint;

public class Rect extends Shape {
	private int x1;
	private int x2;
	private int x3;
	private int x4;
	
	private int y1;
	private int y2;
	private int y3;
	private int y4;
	
	@Override
	public void draw() {
		// TODO Auto-generated method stub
		System.out.println("사각형을 그렸습니다.");
	}
}
```

**MainApp.java**

```java
package paint;

public class MainApp {

	public static void main(String[] args) {
		// 점 찍기
		Point p1 = new Point(10, 20);
		drawPoint(p1);
		
		// 색깔 점 찍기
		Point p2 = new ColorPoint(50,  100,  "red");
//		drawPoint(p2);
		p2.show(true);
		
		// 점 지우기
		p1.show(false);
		p2.show(false);
		
		Shape triangle = new Triangle();
		draw(triangle);
		
		Shape rect = new Rect();
		draw(rect);
		
	}
	
	public static void drawPoint(Point point) {
		point.show();
	}
	
	public static void draw(Shape shape) {
		shape.draw();
	}
}
```



#### - 원

**Circle.java**

```java
package paint;
public class Circle extends Shape {
	private int x;
	private int y;
	private int radius;
	
	@Override
	public void draw() {
		System.out.println("원을 그렸습니다.");
	}
}
```

**MainApp.java**

```java
		Shape circle = new Circle();
		draw(circle);
```





**문제!!**

**Point까지 포함하는 클래스를 만들고 싶으면**

**interface를 만들어야함**

 **-> Shape를 Point가 상속받으면 fillColor 등 필요없는것도 상속받아야하잖아!**



---

### 5. interface

**Drawable.java**

```java
package paint;

public interface Drawable{
	void draw();
}

```

**Shape.java**

```java
package paint;

public abstract class Shape implements Drawable{
	
	private String fillColor;
	private String lineColor;
    
    public abstract float calcArea();
	// 자식에서 오버라이드 하면 됨
}
```

**자식 클래스들**

```java
	@Override
	public float calcArea() {
		return 0.f;
	}
```

**Point.java**

```java
package paint;

public class Point implements Drawable {
    ...
    ...
        
	@Override
	public void draw() {
		show();
	}

}

```



**MainApp.java** 수정

```java
package paint;

public class MainApp {

	
	public static void main(String[] args) {
		// 점 찍기
		Point p1 = new Point(10, 20);
		draw(p1);
		
		// 색깔 점 찍기
		Point p2 = new ColorPoint(50,  100,  "red");
		draw(p2);
		
		// 점 지우기
		p1.show(false);
		p2.show(false);
		
		Shape triangle = new Triangle();
		draw(triangle);
		
		Shape rect = new Rect();
		draw(rect);
		
		Shape circle = new Circle();
		draw(circle);
		
	}
	
	public static void draw(Drawable drawable) {
		drawable.draw();
	}

}
```

> **메소드 하나로 모두 다 실행할 수 있게됨!!!!!!** 

---

**얼마나 확장성이 높아지고 간편해 졌는지 기능을 추가해볼까??**

---

### 6. 텍스트 그리기

**GraphicString.java**

```java
package paint;

public class GraphicString implements Drawable {
	
	private String text;

	public GraphicString(String text) {
		this.text = text;
	}

	@Override
	public void draw() {
		System.out.println(text + "를 그렸습니다.");

	}
}
```

**MainApp.java**

```java
draw(new GraphicString("hello~~"));
```

**아래 코드 추가, 수정없이 딱 한줄로 해결 가능!**



---

# package 나누기

![1557464968766](assets/1557464968766.png)




