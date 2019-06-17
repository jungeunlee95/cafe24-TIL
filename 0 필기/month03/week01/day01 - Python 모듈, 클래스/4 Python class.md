[TOC]

---

# Python class :page_facing_up:

## :heavy_check_mark: 용어 정리 

```
1) 클래스: class 문으로 정의하며,  멤버와 메써드를 가지는 객체이다.

2) 클래스 객체: 클래스와 같은 의미이지만 어떤 클래스를 구체적으로 가리킬 때 사용될 수 있다.

3) 클래스 인스턴스 : 클래스를 호출하여 만들어지는 객체

4) 클래스 인스턴스  객체 : 클래스 인스턴스와 같은 의미이다. 인스턴스 객체라 부르기도 한다.

5) 멤버 : 클래스가 갖는 변수

6) 메써드 : 클래스 내에  정의된  함수

7) 속성 :  멤버 + 메써드

8) 상위클래스  : 기반 클래스,  어떤 클래스의 상위에 있으며 여러 속성을 상속 해준다. 

9) 하위클래스  : 파생 클래스,  상위 클래스로 부터 여러 속성을 상속 받는다.
```



## :heavy_check_mark: 클래스 정의

**01class_def.py**

```python
class MyString:
    pass

s = MyString()
print(type(s))
print(MyString.__bases__) # 부모

s2 = str()
print(type(s2))
print(str.__bases__)

```

> ```
> <class '__main__.MyString'>
> (<class 'object'>,)
> <class 'str'>
> (<class 'object'>,)
> ```



## :heavy_check_mark: 메서드 정의와 호출

**point.py**

```python
# class point
class Point:
    def set_x(self, x):
        self.x = x

    def get_x(self):
        return self.x

    def set_y(self, y):
        self.y = y

    def get_y(self):
        return self.y
    
    def show(self):
        print(f'점[{self.x}, {self.y}]를 그렸습니다.')
```

**paint.py**

```python
from point import Point

def bound_class_method():
    p = Point()
    p.set_x(10)
    p.set_y(10)
    p.show()

def test_unbound_class_method():
    p = Point()
    Point.set_x(p, 20)
    Point.set_y(p, 20)
    Point.show(p)
    p.show()
    
def main():
    bound_class_method()
    test_unbound_class_method()

if __name__ == '__main__':
    main()
```

> 점[10, 10]를 그렸습니다.
>
> 점[20, 20]를 그렸습니다.
>
> 점[20, 20]를 그렸습니다.



###  메소드

**point.py**

```python
# class point
class Point:
    count_of_instance = 0

    def set_x(self, x):
        self.x = x

    def get_x(self):
        return self.x

    def set_y(self, y):
        self.y = y

    def get_y(self):
        return self.y

    def show(self):
        print(f'점[{self.x}, {self.y}]를 그렸습니다.')

    @classmethod
    def class_method(cls):
        return cls.count_of_instance
    
    @staticmethod
    def static_method():
        print('static method called . . .')
```

**paint.py**

```python
from point import Point

def bound_class_method():
    p = Point()
    p.set_x(10)
    p.set_y(10)
    p.show()

def test_unbound_class_method():
    p = Point()
    Point.set_x(p, 20)
    Point.set_y(p, 20)
    Point.show(p)
    p.show()

def test_other_method():
    # print(Point.class_method(Point))
    print(Point.class_method())
    Point.static_method()

def main():
    # bound_class_method()
    # test_unbound_class_method()
    test_other_method()

if __name__ == '__main__':
    main()
```

> 0
>
> static method called . . .



