[TOC]

---

# str

**문자열 객체의 내용은 변경 할수 없는 변경 불가(Immutable) 자료형**

:x: `str1[0] = ‘f’` :x:

```python
s = ''
str1 = 'hello world'
str2 = "hello world"
print(type(s), type(str1), type(str2))
print(isinstance(str2, str))
```

```python
str3 = """ABCDEFG
abcdef
가나다라마
123456789"""
print(str3)

'''
여기는 주석
멀티 라인 주석 대체 가능!!!
> 변수를 안받아주니까 메모리에서 언젠간 사라질거야
'''
```



**escape**

```python
print('Hello\nWorld\nI SAY "Hello World"')
print('Hello\nWorld\nI SAY \"Hello World\"')
```



**문자열 연산**

```python
str1 = "First String!"
str2 = "Second String~"

print(str1 + str2)
print(str1*3)
print(len(str2))

# 1. 인덱싱
print(str1[2])
print(str1[-1], str2[-1]) # ! ~

# 2. slicing [start:stop:step]
print(str2[2:5])          # con
print(str2[2:10:2])       # cn t

str3 = str2[2:6]
print(type(str3))

print(str2[2:len(str2):1])
print(str2[2:])

s = "Python"
print(s[-1])     # n
print(s[-2:])    # on
print(s[:-2])    # Pyth

print(s[::-1])   # nohtyP
print(s[1::-1])  # s[1],s[0] yP
print(s[:-3:-1]) # no
print(s[-3::-1]) # htyP

```



:x:**문자열 객체와 정수형 객체는 + 연산을 할 수 없다.** :x:

```python
name = "길동"
age = 40

# error
print("name: " + name + ", age:" + age)
```



**문자열 서식**

```python
# 서식(formatting) = format 함수
print("name: " + name + ",age: " + format(age, "d"))
print("name: " + format(name, "s") + ",age: " + format(age, "d"))
```

> 서식 : 튜플이용

```python
f = 'name: %s, age: %d'

print(f % (name, age))
print(f % ('또치', 10))
print(f % ('도우넛', 30))
```

> 서식 : 딕셔너리 이용

```python
f = 'name: %(name)s, age: %(age)d'
print(f)

print(f % {'name' : '정은', 'age' : 25})
print(f % {'name': '또치', 'age': 10})
print(f % {'name': '도우넛', 'age': 30})
```



**문자열 메소드**

**객체함수**

```python
# 1. 대소문자 관련
s = 'I like Python'
print(s.upper())
print(s.lower())
print(s.swapcase())
print(s.capitalize())
print(s.title())
```

> I LIKE PYTHON
> i like python
> i LIKE pYTHON
> I like python
> I Like Python

```python
# 2. 검색
# find
s = 'I Like Python, I Like Java Also'
print(s.count('Like'))
print(s.find('Like'))            # 맨처음 나오는 index
print(s.find('Like', 5))         # index 5부터 찾아라
print(s.find('JavaScript'))      # 없으면 -1
print(s.rfind('Like'))

# index
print(s.index('Like'))
# print(s.index('JavaScript'))   # 없으면 Exception
print(s.rindex("Like"))
print(s.startswith("I Like"))    # T
print(s.startswith("Like", 5))   # F
print(s.startswith("Like", 2))   # T
print(s.endswith("Also"))        # T
print(s.endswith("Java", 0, 26)) # T
```

```python
# 3. 편집과 치환
s = '         spam and ham   '
print('-----' + s.strip() + '-----')
print('-----' + s.rstrip() + '-----')
print('-----' + s.lstrip() + '-----')

s = '<><abc><><defg><><>'
print('-----' + s.strip('<>') + '-----')
print('-----' + s.strip('><') + '-----')
```

> -----spam and ham-----
> -----         spam and ham-----
> -----spam and ham   -----
>
> -----abc><><defg-----
> -----abc><><defg-----

```python
# 4. 분리 & 결합
s = "Hello Java"
print(s.replace('Java', 'Python'))

s = 'spam and ham'
l = s.split(' and ')
print(l, type(l))

s2 = ':'.join(l)
print(s2)
print('^^'.join(l))

s3 = 'one:two:three:four:five'
print(s3.split(':'))
print(s3.split(':', 2))
print(s3.rsplit(':', 2))

lines = '''
1st line
2nd line
3rd line 
4th line
'''
print(lines.split('\n'))
print(lines.splitlines())
```

> Hello Python
> ['spam', 'ham'] <class 'list'>
>
> spam:ham
> spam^^ham
>
> `['one', 'two', 'three', 'four', 'five']`
> `['one', 'two', 'three:four:five']`
> `['one:two:three', 'four', 'five']`
>
> ['', '1st line', '2nd line', '3rd line ', '4th line', '']
> ['', '1st line', '2nd line', '3rd line ', '4th line']

```python
# 5. 판별
print('1234'.isdigit())     # T
print('abcd'.isalpha())     # T
print('1234'.isalpha())     # F
print('abcd'.isdigit())     # F

print('abcd'.islower())     # T
print('ABCD'.isupper())     # T

print('    '.isspace())     # T
print('\r\n'.isspace())     # T
```

```python
# 6. '0' 채우기
print('20'.zfill(5))        # 00020
```

```python
# 7. 서식 : 객체함수
print('name : {}, age : {}'.format('둘리', 20))
print('name : {1}, age : {0}'.format('또치', 22))
print('name : {n}, age : {a}'.format_map({'n':'마이콜', 'a':33}))

print('{:10}의 제곱근은 {:.4}이다.'.format(2, 2**0.5))
```

> name : 둘리, age : 20
> name : 22, age : 또치
> name : 마이콜, age : 33
>
> ​         2의 제곱근은 1.414이다.

