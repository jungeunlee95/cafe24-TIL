[TOC]

---

# **function_def**

```python
def dummy():
    pass

def my_function():
    print('Hello World')

def times(a, b):
    return a * b

def none():
    return

dummy()
my_function()
print(times(10, 10))
print(none())
```

> Hello World
> 100
> None

```python
print('----- 함수도 객체다 ------')
print(dummy, type(dummy))
f = my_function
f()

print(f, my_function)
```

> ```
> ----- 함수도 객체다 ------
> <function dummy at 0x000002372596C268> <class 'function'>
> Hello World
> <function my_function at 0x00000237259E4A60> <function my_function at 0x00000237259E4A60>
> ```

```python
print('----- 여러 return 값 -> tuple로 packing ------')
def func():
    return 10, 'hello', {1, 2, 3}, (1, 2, 3)
print(func())
```

> ----- 여러 return 값 -> tuple로 packing ------
> (10, 'hello', {1, 2, 3}, (1, 2, 3))





---

# callby

```python
def f(i):
    i = 20

a = 10
f(a)
print(a)
```

> 10

```python
# 파라미터가 sequence type(immutable)인 경우 내부에서 변경시 오류
# a = (1, 2, 3) -> error
def f2(seq):
    seq[0] = 0

a = [1,2,3]  # -> 변경!
f2(a)
print(a)
```

> [0, 2, 3]





---

# **scope**

지역변수 먼저 찾고, 글로벌 찾음

```python
def func1(a):
    x = 3
    return a + x

def func2(a):
    return a + x

print(func1(3))
x = 1
print(func2(3))
```

> 6
>
> 4

```python
def func3(a):
    g = 3   # local 변수라 global에서 사용하면 error
    return a + g
```

```python
def func3(a):
    global g # local에서 global 선언하면 사용 가능
    g = 3   
    return a + g
print(func3(10))
print(g) 
```

> 13
> 3





---

# argument

```python
print('---- 기본 인수값 ----')
def incr(a, step=1):
    return a + step

print(incr(10))
print(incr(10,2))
```

> ---- 기본 인수값 ----
> 11
> 12

```python
# 이건 ERROR!!!!!!!!!!!!!!
def decr(step=1, a):
    return a + step
```

```python
def decr(step=1, a=0):
    return a + step

print(decr(step=3))
print(decr(a=3))
print(decr(6, 7))
```

> 3
> 4
> 13



**키워드 인수**

```python
print('---- 키워드 인수 ----')
def area(width, height):
    return width + height

print(area(10, 20))
print(area(width=10, height=20))
print(area(height=10, width=20))
```

> ---- 키워드 인수 ----
> 30
> 30
> 30

> :x: ERROR!!! ;:x:
>
> ```python
> # 오류
> area(20, width=30)
> ```



**가변인수**

```python
print('---- 가변 인수 ----')
def vargs(a, *args):
    print(a, args)

vargs(10)
vargs(10,1)
vargs(10,2,3,4)
```

> ---- 가변 인수 ----
> 10 ()
> 10 (1,)
> 10 (2, 3, 4)

```python
print("---- print 함수 ----")
def _print(*args, end='\n'):
    print(f'{end}'.join(args))

_print("#1 Hello", "Python")
_print("#2 Hello", "Python", end="\t")
```

> ---- print 함수 ----
> #1 Hello
> Python
> #2 Hello	Python

```python
print("---- printf 함수 ----")
def printf(format, *args):
    print(format % args)
printf("%s이 %d원짜리 %s를 입고있다", "정은", 5000, "드레스")
```

> ---- printf 함수 ----
> 정은이 5000원짜리 드레스를 입고있다



**정의되지 않은 키워드 인수 처리하기**

```python
print("---- 정의되지 않은 키워드 인수 처리하기 ----")
def f(width, height, **kw):
    print(width, height)
    print(kw)

f(10, 20)
f(10, 20, depth=10)
f(10, 20, depth=10, dimension=3)
# f(10, 20, depth=10, 3)  error!
```

> ---- 정의되지 않은 키워드 인수 처리하기 ----
> 10 20
> {}
> 10 20
> {'depth': 10}
> 10 20
> {'depth': 10, 'dimension': 3}

```python
def g(a, b, *args, **kw):
    print("a, b : ",a, b)
    print("args : ",args)
    print("kw : ",kw)

print('---------- 1 --------')
g(10, 20)
print('---------- 2 --------')
g(10, 20, 30)
print('---------- 3 --------')
g(10, 20, c=60)
print('---------- 4 --------')
g(10, 20, 30, 40, 50, c=60, d=70)
```

> ```
> ---------- 1 --------
> a, b :  10 20
> args :  ()
> kw :  {}
> ---------- 2 --------
> a, b :  10 20
> args :  (30,)
> kw :  {}
> ---------- 3 --------
> a, b :  10 20
> args :  ()
> kw :  {'c': 60}
> ---------- 4 --------
> a, b :  10 20
> args :  (30, 40, 50)
> kw :  {'c': 60, 'd': 70}
> ```



**튜플/사전 파라미터**

```python
print('-------- 튜플/사전 파라미터 --------')
def h(name, age, height):
    print(name, age, height)

h('둘리', 10, 150)

t = ('둘리', 10, 50)
h(t[0], t[1], t[2])
h(*t)
print('---------------------------------')
d = {'name':'둘리', 'age':10, 'height':150}
h(d['name'], d['age'], d['height'])
```

> ```
> -------- 튜플/사전 파라미터 --------
> 둘리 10 150
> 둘리 10 50
> 둘리 10 50
> ---------------------------------
> 둘리 10 150
> 둘리 10 150
> ```





---

# **normalize_string**

```
문자열 데이터를 분석하기 전에 처리함수 만들기
1. 공백제거
2. 필요없는 문자 부호 제거
3. 대소문자 정리(Capitalize)
```

**[1]**

```python
import re

states = ['Alabama', '  Georgia!', 'Georgia ', 'georgia', 'FlOrIda', 'south carolina   ', 'West virginia?']

def clean_string(strings):
    results = []
    for string in strings:
        string = string.strip()
        string = re.sub('[!#?]', '', string)
        string = string.title()
        results.append(string)
    return results

results = clean_string(states)
print(results)
```

> ['Alabama', 'Georgia', 'Georgia', 'Georgia', 'Florida', 'South Carolina', 'West Virginia']



**[2] 함수 인자 받기**

```python
import re

states = ['Alabama', '  Georgia!', 'Georgia ', 'georgia', 'FlOrIda', 'south carolina   ', 'West virginia?']

def clean_strings(strings, *funcs):
    results = []
    for string in strings:
        for func in funcs:
            string = func(string)
        results.append(remove_special(string))
    return results

def remove_special(s):
    return re.sub('[!#?]', '', s)

results = clean_strings(states, str.strip, str.title)
print(results)
```

> ['Alabama', 'Georgia', 'Georgia', 'Georgia', 'Florida', 'South Carolina', 'West Virginia']





---

# **lamda** : 익명함수

```python
def f(x):
    return x * 2

for i in range(10):
    print(f'{i}:{f(i)}', end=' ')
print()

print('----------------------------')
for i in range(10):
    print(f'{i}:{(lambda x : x*2)(i)}', end=' ')
print()
```

> ```
> 0:0 1:2 2:4 3:6 4:8 5:10 6:12 7:14 8:16 9:18 
> ----------------------------
> 0:0 1:2 2:4 3:6 4:8 5:10 6:12 7:14 8:16 9:18 
> ```

**이전 식 고쳐보기**

```python
import re

states = ['Alabama', '  Georgia!', 'Georgia ', 'georgia', 'FlOrIda', 'south carolina   ', 'West virginia?']

def clean_strings(strings, *funcs):
    results = []
    for string in strings:
        for func in funcs:
            string = func(string)
        results.append(string)
    return results

results = clean_strings(states, str.strip, str.title, lambda s: re.sub('[!#?]', '', s))
print(results)
```

> ['Alabama', 'Georgia', 'Georgia', 'Georgia', 'Florida', 'South Carolina', 'West Virginia']



## Java에서 lambda

**Myinterface.java**

```java
package lambda;
public interface MyInterface {
	public int arith(int x, int y);
}
```

**MainApp.java**

```java
package lambda;

public class MainApp {

	public static void main(String[] args) {
		Thread t = new Thread(new Runnable() {
			@Override
			public void run() {
				System.out.println("Hello World");
			}
		});
		
		
		Thread t2 = new Thread(() -> {
			System.out.println("Hello World!!!");
		});
		
		
		Test(new MyInterface() {
			@Override
			public int arith(int x, int y) {
				return x / y;
			}
		});
		
		
		Test((x, y) -> {
			return x * y;
		});
		
		Test((x, y) -> x + y);
		
	}
	
	public static void Test(MyInterface i) {
		System.out.println(i.arith(3, 4));
	}
}
```

> 0
> 12
> 7

> 인터페이스 메소드를 람다로 구현!


