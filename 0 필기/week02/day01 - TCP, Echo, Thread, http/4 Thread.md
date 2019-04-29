**thread/ThreadEx01.java**

```java
package thread;

public class ThreadEx01 {

	public static void main(String[] args) {

		for(int i = 0; i < 10; i++) {
			System.out.print(i);
		}
		
		for(char c = 'a'; c <= 'z'; c++) {
			System.out.print(c);
		}
	}
}
```

**thread 만들기 전**

```
> 0123456789abcdefghijklmnopqrstuvwxyz
```



**thread/DigitThread.java**

```java
package thread;
public class DigitThread extends Thread {
	@Override
	public void run() {
		for(int i = 0; i < 10; i++) {
			System.out.print(i);
		}
	}
}
```

**thread/ThreadEx01.java**

```java
package thread;
public class ThreadEx01 {
	public static void main(String[] args) {
        
		Thread digitThread = new DigitThread();
		digitThread.start();
        
		for(char c = 'a'; c <= 'z'; c++) {
			System.out.print(c);
		}
	}
}
```

> ![1556506395652](assets/1556506395652.png)
>
> loop는 선점이 안되기때문에 a0b1 이런식으로 순서대로는 안나옴! 어쨋든 섞였네~
>
> ```
> > a0bcdefghijklmnopqrstuvwxyz123456789
> ```



#### 그럼 번갈아가게 찍히게 sleep을 넣어볼까?

```java
try {
	Thread.sleep(1000);
} catch (InterruptedException e) {
	e.printStackTrace();
}
```

```
> a0b1c2d3e4f5g6h7i8j9klmnopqrstuvwxyz
```



**알파벳도 thread로!**

**thread/AlpabetThread.java**

```java
package thread;
public class AlpabetThread extends Thread {

	@Override
	public void run() {
		for(char c = 'a'; c <= 'z'; c++) {
			System.out.print(c);
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
}
```

**ThreadEx02.java**

```java
package thread;

public class ThreadEx02 {

	public static void main(String[] args) {
		Thread thread1 = new DigitThread();
		Thread thread2 = new AlpabetThread();
		Thread thread3 = new DigitThread();
		
		thread1.start();
		thread2.start();
		thread3.start();
	}
}
```

```
> 0a011bc22d33e44f55g667h788i9j91010kl11111212m1313no1414p ....
```

---



#### OCP 설계원칙 - 개방폐쇄의 원칙

> <http://www.nextree.co.kr/p6960/>

#### 상속 ?  

> 기능을 물려받기, 유연하게 수정없이 기능 확장하기! 



---



#### 일반 클래스 메소드를 Thread에 태우기 !

**Thread/UppercaseAlphabet.java**

```java
package thread;
public class UppercaseAlphabet {
	public void print() {
		for(char c = 'A'; c <= 'Z'; c++) {
			System.out.println(c);
		}
	}
}
```

**UppercaseAlphabetRunnableImpl**   :  위의 클래스를 thread에 태우기 위한 클래스 

```java
package thread;

public class UppercaseAlphabetRunnableImpl extends UppercaseAlphabet implements Runnable {
	@Override
	public void run() {
		print();
	}
}
```

**ThreadEx03.java**

```java
package thread;
public class ThreadEx03 {

	public static void main(String[] args) {
		Thread thread1 = new DigitThread();
		Thread thread2 = new AlpabetThread();
		Thread thread3 = new Thread(new UppercaseAlphabetRunnableImpl());
		
		thread1.start();
		thread2.start();
		thread3.start();
	}
}
```

```
> a0ABCDEFGHIJKLMNOPQRSTUVWXYZ1b2cd3e4f5g6h7i8j9klmnopqrstuvwxyz
```

