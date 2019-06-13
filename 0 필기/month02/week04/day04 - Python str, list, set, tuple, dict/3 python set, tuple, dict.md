[TOC]

---

# set

**시퀀스 자료형이 아니기 때문에 시퀀스의 연산 중 len(), in, not in 정도만 가능**

```python
a = {1, 2, 3}
print(a, type(a))

print(len(a))
print(2 in a)
print(2 not in a)
```

> {1, 2, 3} <class 'set'>
> 3
> True
> False

```python
nums = [1, 2, 3, 2, 2, 4, 5, 6, 5, 6]
s = set(nums)
print(s)
nums = list(s)
print(nums)
```

> {1, 2, 3, 4, 5, 6}
> [1, 2, 3, 4, 5, 6]

```python
# 객체 함수
print("---------객체함수------")
print(s)
s.add(4)
print(s)
s.add(1)
print(s)
s.discard(2)
print(s)
s.remove(3)
print(s)
s.update({2, 3})
print(s)
s.clear()
print(s)
s.add(3)
print(s)
```

> ---------객체함수------
> {1, 2, 3, 4, 5, 6}
> {1, 2, 3, 4, 5, 6}
> {1, 2, 3, 4, 5, 6}
> {1, 3, 4, 5, 6}
> {1, 4, 5, 6}
> {1, 2, 4, 5, 6, 3}
> set()
> {3}

```python
# 수학 집합 관련 객체 함수
print("---------수학 집합 관련 객체 함수------")
s1 = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
s2 = {10, 20, 30}

s3 = s1.union(s2)                  # 합집합
print(s3)

s3 = s1.intersection(s2)           # 교집합
print(s3)

s3 = s1.difference(s2)             # 차집합
print(s3)

s3 = s1.symmetric_difference(s2)   # 교집합의 여집합?
print(s3)

s4 = {1}
print(s1.issubset(s4))             # F
print(s4.issubset(s1))             # T
```

> ---------수학 집합 관련 객체 함수------
> {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 30}
> {10}
> {1, 2, 3, 4, 5, 6, 7, 8, 9}
> {1, 2, 3, 4, 5, 6, 7, 8, 9, 20, 30}
> False
> True



# tuple

> **시퀀스 자료형**

```python
# 튜플 생성
t = ()      # 공튜플
t = (1,)    # 항목이 하나일 때는 반드시 ,(콤마) 사용
print(t, type(t))
t = (1, 2, 3)
print(t, type(t))
```

> (1,) <class 'tuple'>
> (1, 2, 3) <class 'tuple'>

```python
print("----sequence 연산-----")
# sequence 연산
# 인덱싱
print(t[-3], t[-2], t[-1], t[0], t[1], t[2])

# 슬라이싱
print(t[1:3])
print(t[::-1])

# 반복
print(t*2)

# 연결
print(t + (99,))

# 확인
print(4 not in t)

# immutable
# t[0] = (100,)
# print(t)
```

> ----sequence 연산-----
> 1 2 3 1 2 3
> (2, 3)
> (3, 2, 1)
> (1, 2, 3, 1, 2, 3)
> (1, 2, 3, 99)
> True

```python
print("----swap-----")
# 여러개 값 대입
x, y, z = (10, 20, 30)
print(x, y, z)

# swap
x, y = 10, 20
print(x, y)
x, y = y, x
print(x, y)
```

> ----swap-----
> 10 20 30
> 10 20
> 20 10

```python
# 객체함수
print("-------객체함수---------")
t = (1, 2, 3)

s = set(t)
print(s, type(s))

l = list(s)
print(l, type(l))

t = tuple(l)
print(t, type(t))
```

> -------객체함수---------
> {1, 2, 3} <class 'set'>
> [1, 2, 3] <class 'list'>
> (1, 2, 3) <class 'tuple'>



### packing, unpacking

```python
# packing : tuple만 가능
print("-------packing---------")
t = 10, 20, 30, 'python'
print(t, type(t))

# unpacking
print("-------unpacking---------")
a, b, c, d = t
print(a, b, c, d)

# error
# a, b, c = t
# a, b, c, d, e = t

print("----확장 언패킹------")
t = (1, 2, 3, 4, 5, 6)
a, *b = t
print(a,  b)

*a, b = t
print(a, b)
```

> -------packing---------
> (10, 20, 30, 'python') <class 'tuple'>
> -------unpacking---------
> 10 20 30 python
> ----확장 언패킹------
> 1 [2, 3, 4, 5, 6]
> [1, 2, 3, 4, 5] 6
> 1 2 [3, 4, 5, 6]
> 1 [2, 3, 4, 5] 6

```python
# cf, 여러개 파라미터 받는 함수
def sum1(*num):
    return sum(num)
print(sum1(1, 2, 3, 4))
```

> 10

```python
print("-------printf---------")
# c의 printf() 함수 흉내
def printf(str, *a):
    print(str % a)
printf("name : %s, age: %d", "둘리", 10)
```







# dict

**시퀀스 자료형이 아니기 때문에 시퀀스의 연산 중 len(), in, not in 정도만 가능**

```python
d = {'basketball': 5, 'soccer': 11, 'baseball': 9}
print(d, type(d))

print(d['basketball'])

# 변경가능
d['volleyball'] = 6
print(d)

# 길이
print(len(d))

# in, not in by key
print('soccer' in d)
print('volleyball' not in d)
```

> {'basketball': 5, 'soccer': 11, 'baseball': 9} <class 'dict'>
> 5
> {'basketball': 5, 'soccer': 11, 'baseball': 9, 'volleyball': 6}
> 4
> True
> False

```python
print("----------다양한 dict 객체 생성 방법----------")
# key : immutable만 가능
d = dict()   # empty dict
print(d)

d = dict(one=1, two=2)  # keyword arguments
print(d)

d = dict([('one', 1), ('two', 2)])   # tuple list
print(d)

keys = ('one', 'two', 'three')
values = (1, 2, 3)
d = dict(zip(keys, values))
print(d)
```

> ----------다양한 dict 객체 생성 방법----------
> {}
> {'one': 1, 'two': 2}
> {'one': 1, 'two': 2}
> {'one': 1, 'two': 2, 'three': 3}

```python
print("----------다양한 key 타입----------")
# key : immutable만 가능
d = {}
d[True] = 'ture'
d[10] = '10'
d['twenty'] = 20
#d[[1,2,3]] = '6' # error
print(d)

print("----------key 객체----------")
keys = d.keys()
print(keys, type(keys))
for key in keys:
    print(f"{key} : {d[key]}")
    
print("----------values 객체----------")
values = d.values()
print(values, type(values))

print("----------items 객체----------")
items = d.items()
print(items, type(items))    
```

> ----------다양한 key 타입----------
> {True: 'ture', 10: '10', 'twenty': 20}
>
> ----------key 객체----------
> dict_keys([True, 10, 'twenty']) <class 'dict_keys'>
> True : ture
> 10 : 10
> twenty : 20
>
> ----------values 객체----------
> dict_values(['ture', '10', 20]) <class 'dict_values'>
>
> ----------items 객체----------
> dict_items([(True, 'ture'), (10, '10'), ('twenty', 20)]) <class 'dict_items'>



```python
print("----------dict 복사----------")
phone = {
    '둘리' : '000-0000-0000',
    '마이콜' : '000-1111-1111',
    '또치' : '000-2222-2222'
}

p = phone
print(p)
print(phone)

p['도우넛'] = '000-3333-3333'
print(p)
print(phone)
```

> ----------dict 복사----------
> {'둘리': '000-0000-0000', '마이콜': '000-1111-1111', '또치': '000-2222-2222'}
> {'둘리': '000-0000-0000', '마이콜': '000-1111-1111', '또치': '000-2222-2222'}
> {'둘리': '000-0000-0000', '마이콜': '000-1111-1111', '또치': '000-2222-2222', '도우넛': '000-3333-3333'}
> {'둘리': '000-0000-0000', '마이콜': '000-1111-1111', '또치': '000-2222-2222', '도우넛': '000-3333-3333'}



## copy()

```python
print("-------- copy() --------")
p = phone.copy()
print(p)
print(phone)

p['또리'] = '000-4444-4444'
print(p)
print(phone)
```

> -------- copy() --------
> {'둘리': '000-0000-0000', '마이콜': '000-1111-1111', '또치': '000-2222-2222', '도우넛': '000-3333-3333'}
> {'둘리': '000-0000-0000', '마이콜': '000-1111-1111', '또치': '000-2222-2222', '도우넛': '000-3333-3333'}
> {'둘리': '000-0000-0000', '마이콜': '000-1111-1111', '또치': '000-2222-2222', '도우넛': '000-3333-3333', '또리': '000-4444-4444'}
> {'둘리': '000-0000-0000', '마이콜': '000-1111-1111', '또치': '000-2222-2222', '도우넛': '000-3333-3333'}



### get()

```python
print("-------- get() --------")
print(phone.get("도우넛"))
print(phone.get("또리"))
print(p.get("또리"))
```

> -------- get() --------
> 000-3333-3333
> None
> 000-4444-4444



## setdefault()

```python
print("-------- setdefault()--------")
print(phone.setdefault("둘리", "99"))
print(phone)
print(phone.setdefault("또리", "000-4444-4444"))
print(phone)
```

> -------- setdefault()--------
> 000-0000-0000
> {'둘리': '000-0000-0000', '마이콜': '000-1111-1111', '또치': '000-2222-2222', '도우넛': '000-3333-3333'}
> 000-4444-4444
> {'둘리': '000-0000-0000', '마이콜': '000-1111-1111', '또치': '000-2222-2222', '도우넛': '000-3333-3333', '또리': '000-4444-4444'}



## 삭제

```python
print("-------- 삭제+values --------")
number = phone.pop('둘리')
print(number)
print(phone)

print("-------- 튜플로 가져오기 popitem --------")
item = phone.popitem()
print(item)
print(phone)
```

> -------- 삭제+values --------
> 000-0000-0000
> {'마이콜': '000-1111-1111', '또치': '000-2222-2222', '도우넛': '000-3333-3333', '또리': '000-4444-4444'}
> -------- 튜플로 가져오기 popitem --------
> ('또리', '000-4444-4444')
> {'마이콜': '000-1111-1111', '또치': '000-2222-2222', '도우넛': '000-3333-3333'}





```python
print("-------- update --------")
phone.update({
    '도우넛' : '999-9999-9999',
    '바보' : '00'
})
print(phone)

print("-------- 모두 삭제 --------")
phone.clear()
print(phone)
```

> -------- update --------
> {'마이콜': '000-1111-1111', '또치': '000-2222-2222', '도우넛': '999-9999-9999', '바보': '00'}
> -------- 모두 삭제 --------
> {}



