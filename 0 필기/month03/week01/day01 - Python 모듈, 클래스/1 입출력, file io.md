[TOC]

---

# 입출력

```python
print(1)
print('hello', 'world')

# sep 파라미터
x = 0.2
s = 'hello'
print(str(x) + ' ' + s)
print(x, s, sep=' ')

# 기본적인 print() 함수 호출
print(sep=' ', end='\n')
```

`import sys` 사용

```python
# file 파라미터 지정
print('Hello World', file=sys.stdout)
print('error : hello world', file=sys.stderr)
```

> ![1560730192219](assets/1560730192219.png)



**파일 읽고 쓰기**   ![1560730298286](assets/1560730298286.png)

```python
f = open('hello.txt', 'w')
print(type(f))
print('hello world', file=f)
f.close()
```



---



# file io

**write**

```python
# textmode 가 default : t
f = open('test.txt', 'w', encoding='utf-8')
write_size = f.write('안녕하세요\n파이썬입니다.') # return file size
print(write_size)
```

> ![1560730505712](assets/1560730505712.png)
>
> ```
> 13
> ```



**binary mode**

```python
# binary mode : b
f = open('test2.txt', 'wb')
write_size = f.write(bytes('안녕하세요\n파이썬입니다.', encoding='utf-8'))
f.close()
print(write_size)
```

> ```
> 35
> ```



**read**

```python
# binary mode : b
f = open('test2.txt', 'wb')
write_size = f.write(bytes('안녕하세요\n파이썬입니다.', encoding='utf-8'))
f.close()
print(write_size)
```

> ```
> 안녕하세요
> 파이썬입니다.
> ```



**binary read : copy file**

```python
print('--------copy file--------')
# binary read : copy file
fsrc = open('python.png', 'rb')
data = fsrc.read()
fsrc.close()
print(type(data))

fdest = open('python2.png', 'wb')
fdest.write(data)
fdest.close()
```

> ```
> --------copy file--------
> <class 'bytes'>
> ```
>
> ![1560731036820](assets/1560731036820.png)

---

# file io 2

```python
f = open('test.txt','rt',encoding='utf-8')
text = f.read()
print(text)
text = f.read()
print("---", text, "---")
```

> ```
> 안녕하세요
> 파이썬입니다.
> ---  ---
> ```



**position**

```python
# position 단위는 byte
pos = f.tell() # 현재 position
print(pos)     # 전체 파일 size = 35니까 36이면 다읽고 그 다음 위치겠네
```

> 36



**seek**

```python
print('------- seek --------')
# 1st parameter : offset
# 2nd parameter : from_what(0:파일시작, 1:현재위치, 2:끝)
# text mode에서는 from_what은 0(파일시작)만 허용
# 예외는 f(0, 2) 끝으로 이동하는 경우
f.seek(16, 0)
text = f.read()
print(text)
```

> ```
> ------- seek --------
> 
> 파이썬입니다.
> ```

```python
# 예외 : f(0, 2) 끝으로 이동하는 경우
f.seek(0,2) # 맨 끝으로 이동
```





**readline() : line 단위로 읽기**

```python
print('-------- line ---------')
line_num = 0
f2 = open('3.fileio2.py', 'rt', encoding='utf-8')
while True:
    line = f2.readline()
    if line == '':
        f2.close()
        break
    line_num += 1
    print(f'{line_num} : {line}', end='')
```



**readlines()**

```python
print('-------------- readlines() --------------')
f3 = open('3.fileio2.py', 'rt', encoding='utf-8')
lines = f3.readlines()
f3.close()
print(type(lines))
for line_num, line in enumerate(lines) :
    print(f'{line_num} : {line}', end='')
```



## **f seek**

```python
f = open('123.txt', 'wb')
f.write(b'0123456789')
f.close()

f = open('123.txt', 'rb')
print("1 : ", f.tell())

f.seek(5, 1)
data = f.read(2)
print("2 : ", data)

f.seek(-5, 1)
data = f.read(3)
print("3 : ", data)

f.seek(0, 2)
data = f.read(3)
print("4 : ", data)
```

> ```
> 1 :  0
> 2 :  b'56'
> 3 :  b'234'
> 4 :  b''
> ```



## with ~as

```python
# with ~as
print('-------- with ~as ---------')
with open('3.fileio2.py', 'rt', encoding='utf-8') as f2:
    for line_num, line in enumerate(f2.readlines()):
        print(f'{line_num} : {line}', end='')
```



