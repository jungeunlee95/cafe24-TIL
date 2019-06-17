[TOC]

---



# **symbol-table**

## 심볼 테이블 내용 확인

```python
g_a = 1
g_b = '둘리'

def f():
    l_a = 2
    l_b = '마이콜'
    print("@@", locals())

for i in range(10):
    g_c = 3
    g_d = 'python'
    print("##", locals())

f()
print("^^", globals())
```

> ```
> ## ...  'g_a': 1, 'g_b': '둘리', 'f': <function f at 0x0000026B7FF8C268>, 'i': 0, 'g_c': 3, 'g_d': 'python'}
> 
> @@ {'l_a': 2, 'l_b': '마이콜'}
> 
> ^^ ... 'g_a': 1, 'g_b': '둘리', 'f': <function f at 0x0000026B7FF8C268>, 'i': 9, 'g_c': 3, 'g_d': 'python'}
> ```



## 1. 정의된 함수

```python
print('-----------1. 정의된 함수 -----------')
f.k = 'hello'
f.haha = "haha!!!"
print("f.haha : ", f.haha)
print("f.__dict__ : ", f.__dict__)
```

> ```
> -----------1. 정의된 함수 -----------
> f.haha :  haha!!!
> f.__dict__ :  {'k': 'hello', 'haha': 'haha!!!'}
> ```



## 2. 클래스 객체

```python
print('-----------2. 클래스 객체 -----------')
class MyClass:
    x = 10
    y = 20
g_a = 1

MyClass.z = 10
print("MyClass.__dict__ : ", MyClass.__dict__)
```

> ```
> -----------2. 클래스 객체 -----------
> MyClass.__dict__ :  {'__module__': '__main__', 'x': 10, 'y': 20, '__dict__': <attribute '__dict__' of 'MyClass' objects>, '__weakref__': <attribute '__weakref__' of 'MyClass' objects>, '__doc__': None, 'z': 10}
> ```

---

**내장 함수는 심벌 테이블이 아니다! -> 확장 :x:**

```python
print.z = 10
print(print.__dict__)
```

**내장 클래스는 심볼 테이블은 있으나 확장:x:**

```python
str.z = 10
print(str.__dict__)
```

**내장 클래스로 생성된 객체는 심볼테이블X -> 확장 :x:**

```python
print('-----------내장 클래스로 생성된 객체 -----------')
print("g_a : ", g_a)
# print("g_a.__dict__ : ", g_a.__dict__)  : error
```

> ```
> -----------내장 클래스로 생성된 객체 -----------
> g_a :  1
> Traceback (most recent call last):
>   File "D:/dowork/PycharmProjects/python_ch02.2/2. 객체/1.symbol-table.py", line 46, in <module>
>     print("g_a.__dict__ : ", g_a.__dict__)
> AttributeError: 'int' object has no attribute '__dict__'
> ```



**사용자 정의 클래스로 생성된 객체는 심볼테이블 O -> 확장 :o:!!!!!**​

```python
print('----------------------')
# 사용자 정의된 클래스로 생성된 객체는 심볼테이블 O -> 확장O
o = MyClass()
o.z = 10
print(o.__dict__)
```

> ```
> ----------------------
> {'z': 10}
> ```



---



# **ref_count**

```python
x = object()
print(type(x))
```

> <class 'object'>

```python
print(sys.getrefcount(x))
```

> 2
>
> 함수 호출할때 넘어간 argument까지 2개

```python
y = x
print(sys.getrefcount(x))
```

> 3



## 레퍼런스 값 줄이기

```python
print('--------레퍼런스 값 줄이기---------')
print(globals())
del x
print(sys.getrefcount(y))
print(globals())
```

> ```
> --------레퍼런스 값 줄이기---------
> before : ...  'x': <object object at 0x000001920CBBE0B0>, 'y': <object object at 0x000001920CBBE0B0>}
> 2
> after : ...  'y': <object object at 0x000001920CBBE0B0>}
> ```
>
> > 심볼 테이블에서 x를 날림 : x 접근 불가!





# obj_id

```python
i1 = 10
i2 = 10
print(hex(id(i1)), hex(id(i2)))

i1 = 11
i2 = 10 + 1
print(hex(id(i1)), hex(id(i2)))

s1 = 'hello'
s2 = 'hello'
print(hex(id(s1)), hex(id(s2)))
```

> 0x7ff97a23e470 0x7ff97a23e470
> 0x7ff97a23e490 0x7ff97a23e490
> 0x23d830c6688 0x23d830c6688

```python
print('---------is-----------')
print(i1 is i2)
print(s1 is s2)
```

> ---------is-----------
> True
> True

```python
print('---------()-----------')
t1 = (1, 2, 3)
t2 = (1, 2, 3)
print(sys.getrefcount(t1), sys.getrefcount(t2))
print(t1 is t2)
```

> ---------()-----------
> 5 5
> True

```python
print('---------tuple()-----------')
t3 = tuple(range(1,4))
print(sys.getrefcount(t3))
print(t1 is t3)
```

> ---------tuple()-----------
> 2
> False

```python
print('---------slicing-----------')
t4 = (0,1,2,3)[1:]
print(t1 is t4)
print(t3 is t4)
```

> ---------slicing-----------
> False
> False



---

# **obj_copy**

```python
a = 1
b = a

a = [1, 2, 3]
b = [4, 5, 6]
x = [a, b, 100]
y = x

print(x)
print(y)
print(x is y)
```

> ```
> [[1, 2, 3], [4, 5, 6], 100]
> [[1, 2, 3], [4, 5, 6], 100]
> True
> ```

**얕은복사**

```python
print('------ swallow copy(얕은 복사) ------')
a = [1, 2, 3]
b = [4, 5, 6]
x = [a, b, 100]
y = copy.copy(x)

print(x)
print(y)
print(x is y)
print(x[0] is y[0])

x[0] = 'change'
y[0] = 'xxxxxx'
print(x)
print(y)
```

> ------ swallow copy(얕은 복사) ------
> [[1, 2, 3], [4, 5, 6], 100]
> [[1, 2, 3], [4, 5, 6], 100]
> False
> True
> ['change', [4, 5, 6], 100]
> ['xxxxxx', [4, 5, 6], 100]

**깊은 복사**

```python
print('------ deep copy(깊은 복사) ------')
a = [1, 2, 3]
b = [4, 5, 6]
x = [a, b, 100]
y = copy.deepcopy(x)

print(x)
print(y)
print(x is y)
print(x[0] is y[0])

x[0] = 'change'
y[0] = 'xxxxxx'
print(x)
print(y)
```

> ------ deep copy(깊은 복사) ------
> [[1, 2, 3], [4, 5, 6], 100]
> [[1, 2, 3], [4, 5, 6], 100]
> False
> False
> ['change', [4, 5, 6], 100]
> ['xxxxxx', [4, 5, 6], 100]



깊은 복사가 복합 객체만을 생성하기 때문에,

복합 객체가 한개만 있는 경우에는 

**얕은복사, 깊은복사 차이가 없다!**

```python
print('------ 얕은 복사 ------')
a = ['hello', 'world']
b = copy.copy(a)
print(a is b)
print(a[0] is b[0])

print('------ 깊은 복사 ------')
a = ['hello', 'world']
b = copy.deepcopy(a)
print(a is b)
print(a[0] is b[0])
```

> ------ 얕은 복사 ------
> False
> True
> ------ 깊은 복사 ------
> False
> True



