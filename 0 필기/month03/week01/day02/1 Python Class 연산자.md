[TOC]

---

# class 멤버, instance 멤버

코드 : [python-basic - 7.클래스/*]([https://github.com/jungeunlee95/python-basic/tree/master/7.%20%ED%81%B4%EB%9E%98%EC%8A%A4](https://github.com/jungeunlee95/python-basic/tree/master/7. 클래스))

```python
class Point:
    count_of_instance = 0 # 클래스 멤버

    def set_x(self, x):
        self.x = x		  # 인스턴스 멤버
```

>    1)  클래스 멤버는 클래스 이름공간에 생성
>
>    2) 인스턴스 멤버는 인스턴스 이름공간에 생성
>
>    3) 클래스 멤버는 모든 인스턴스 객체들에서 공유
>
>    4) 인스턴스 멤버는 각각의 인스턴스 객체에서만 참조
>
> **인스턴스 객체에서 참조하는 멤버의 객체를 찾는 순서**
>
> 1. 인스턴스  멤버
> 2. 만일, 인스턴스 멥버가 존재하지 않으면 클래스 멤버를 찾게 된다.



**:heavy_check_mark: class 멤버, instance 멤버 접근**

```python
def test_other_method():
    print(Point.class_method())
    Point.static_method()

def test_member():
    p = Point()
    p.set_x(30)
    p.set_y(30)
    print(f'{p.x}, {p.y}, {p.count_of_instance}, {Point.count_of_instance}')
    p.count_of_instance = 2000
    Point.count_of_instance = 3000
    print(f'{p.x}, {p.y}, {p.count_of_instance}, {Point.count_of_instance}')

def main():
    print('# 1 : ', end=' '); test_other_method()
    test_member()
    print('# 2 : ', end=' '); test_other_method()
```

> ```
> # 1 :  1000
> static method called . . .
> 30, 30, 1000, 1000
> 30, 30, 2000, 3000
> # 2 :  3000
> static method called . . .
> ```

---



---

# 생성자와 소멸자

생성자 : `__init__`

소멸자 : `__del__`

**point.py**

```python
# class point
class Point:
    count_of_instance = 0

    # 생성자
    def __init__(self, x=0, y=0):
        self.x, self.y = x, y
        Point.count_of_instance += 1

    # 소멸자
    def __del__(self):
        Point.count_of_instance -= 1
...

```

**paint.py**

```python
def test_constructor():
    p1 = Point(10, 20)
    print(f'{p1.x}, {p1.y}, {p1.count_of_instance}, {Point.count_of_instance}')

    p2 = Point(10, 20)
    print(f'{p2.x}, {p2.y}, {p2.count_of_instance}, {Point.count_of_instance}')
    print(f'{p1.count_of_instance}')

    del p1
    print(f'{Point.count_of_instance}')

def main():

    test_constructor()
```

---



---

# `__str__`와 `__repr__`

`__str__`  : 객체를 문자열로 반환

**point.py**

```python
class Point:
    def __str__(self):
        return str(type(self)) + " Point({0}, {1})".format(self.x, self.y)
```

**paint.py**

```python
def test_to_string():
    p = Point()
    print(p)

def main():
    test_to_string()
```

> <class 'point.Point'>Point(0, 0)



`__repr__` : `__str__`이 만들어 내는 문자열 보단, 하나의 객체에 대한 유일한 문자열이여야 한다!, `eval()`을 통해 같은 객체로 재생이 가능한 문자열 표현이여야 함!!!

**point.py**

```python
class Point:
    def __str__(self):
        # return str(type(self)) + " Point({0}, {1})".format(self.x, self.y)
        return self.__repr__()

    def __repr__(self):
        return "Point({0}, {1})".format(self.x, self.y)
```

**paint.py**

```python
def test_to_string():
    p = Point()
    print(p)
    print(repr(p))

    p2 = eval(repr(p))
    print(p2)
    
def main():
    test_to_string()    
```

> ```
> Point(0, 0)
> Point(0, 0)
> Point(0, 0)
> ```

---





---

# class 실습 연습

**rect.py**

```python
# class rect

class Rect():

    def __init__(self, x1=0, y1=0, x2=0, y2=0):
        self.x1, self.y1, self.x2, self.y2 = x1, y1, x2, y2

    def __str__(self):
        return self.__repr__()

    def __repr__(self):
        return "Rect({0}, {1}, {2}, {3})".format(self.x1, self.y1, self.x2, self.y2)

    def area(self):
        return (self.x2 - self.x1) * (self.y2 - self.y1)

    def draw(self):
        print("{0}를 그렸습니다.".format(self))


def test_class_rect():
    r1 = Rect(10, 10, 50, 50)
    r2 = eval(repr(r1))

    print(r1, str(r1.area()), sep=':')
    print(r2, str(r2.area()), sep=':')

    r1.draw()
    r2.draw()

test_class_rect()
```

> ```
> Rect(10, 10, 50, 50):1600
> Rect(10, 10, 50, 50):1600
> Rect(10, 10, 50, 50)를 그렸습니다.
> Rect(10, 10, 50, 50)를 그렸습니다.
> ```

---



---

# 연산자

**mystring.py**

```python
class MyString:

    def __init__(self, s):
        self.s = s

    def __truediv__(self, other):
        return self.s.split(other)

s = MyString('Python Programmer is Good')
t = s / ' '
print(type(t))
print(t)
```

> ```
> <class 'list'>
> ['Python', 'Programmer', 'is', 'Good']
> ```



## :heavy_check_mark:연산자 종류

```
+:__add__    
-:__sub__   
*:__mul__  
//:__floordiv__   
%:__mod__  
divmod():__divmod__
pow(),**:__pow__  
<<:__lshift__  
>>:__rshift__  
&:__and__ 
^:__xor__  
|:__or__  
```

**예제**

```python
class MyString:

    def __init__(self, s):
        self.s = s

    def __truediv__(self, other):
        return self.s.split(other)

    def __add__(self, other):
        return self.s + other
    
    def __mul__(self, cnt):
        return self.s * cnt
    
s = MyString('Python Programmer is Good')
t = s / ' '
print(type(t))
print(t)

print(s + " HaHa")

print(MyString('Python')*3)
```

> ```
> <class 'list'>
> ['Python', 'Programmer', 'is', 'Good']
> Python Programmer is Good HaHa
> ```



```python
class MyString:
    def __add__(self, other):
        return MyString(self.s + other.s)
    
    def __str__(self):
        return self.s
    
# print(s + " HaHa")
print(s + MyString(" HaHa"))
print(MyString("Hello") + MyString(" !!! ") + MyString("~~"))
```

> ```
> Python Programmer is Good HaHa
> Hello !!! ~~
> ```



  ​ ​ ​    ​ :x:     MyString(‘....’) + ‘...’  인 경우, `__add__` 연산자가 호출되지만	:x:

​        ‘...’ + MyString(‘....’)  인 경우, `__radd__` 연산자가 호출되기 때문에 에러가 발생!

		> ​				`print('Hello' + MyString('World'))` 는 에러남!!!!



## :heavy_check_mark:역이항 연산자 오버로딩 메서드

```
+:__radd__    
-:__rsub__   
*:__rmul__  
//:__rfloordiv__   
%:__rmod__  
divmod():__rdivmod__
pow(),**:__rpow__  
<<:__rlshift__  
>>:__rrshift__  
&:__rand__ 
^:__rxor__  
|:__ror__  
```

```python
class MyString:
    def __radd__(self, other):
        return other + self.s
    
print('Hello ' + MyString('World'))
```

> ```
> Hello World
> ```



## :heavy_check_mark:확장 산술 연산자 오버로딩 메서드

```
+=:__iadd__    
-=:__isub__   
*=:__imul__  
/=: __idiv__  
//=:__ifloordiv__   
%=:__imod__
**=:__ipow__  
<<=:__ilshift__  
>>=:__irshift__  
&=:__iand__ 
^=:__ixor__  
|=:__ior__ 
```



## :heavy_check_mark:수치 단항 연산자 오버로딩 메서드

```
-:__neg__    
+:__pos__   
abs():__abs__ 
~: __invert__
```



## :heavy_check_mark:비교 연산자 오버로딩 메서드

```
<:__lt__    
<=:__le__   
>:__gt__  
>=: __ge__  
==:__eq__  
!=:__ne__ 
```



## :heavy_check_mark:시퀀스 자료형 연산자 오버로딩 메서드

```
<:__lt__    
<=:__le__   
>:__gt__  
>=: __ge__  
==:__eq__  
!=:__ne__ 
```

