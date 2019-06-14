[TOC]

---



# condition

## if ~ else

```python
print('--- if else ---')
a = 10
if a > 5:
    print("big")
else:
    print("small")
```

> --- if else ---
> big

```python
print('--- if elif else ---')
n = -2
if n > 0:
    print('양수')
elif n < 0:
    print('음수')
else:
    print('0')

order = 'spam'
if order == 'spam':
    price = 1000
elif order == 'egg':
    price = 500
elif order == 'spagetti':
    price = 2000
else:
    price = 0

print(price)
```

> --- if elif else ---
> 음수
> 1000

```python
print('big' if a > 5 else 'small')
```

> big



## loop

### for

**list, range 객체를 사용**

```python
a = ['cat', 'cow', 'tiger']

for animal in a:
    print(animal)

for x in range(10):
    print(x, end=" ")
print()
```

> cat
> cow
> tiger
> 0 1 2 3 4 5 6 7 8 9 



**복합 자료형 사용**

```python
l = [('둘리', 10), ('마이콜', 20), ('도우넛', 30)]

for data in l:
    print('이름:%s, 나이:%d' % data)

for name, age in l:
    print('이름:{0}, 나이:{1}'.format(name, age))
```

> 이름:둘리, 나이:10
> 이름:마이콜, 나이:20
> 이름:도우넛, 나이:30
> 이름:둘리, 나이:10
> 이름:마이콜, 나이:20
> 이름:도우넛, 나이:30



**enumerate()사용**

```python
l = ['red', 'orange', 'yellow', 'green', 'blue']
for index, color in enumerate(l):
    print(index, color)
```

> 0 red
> 1 orange
> 2 yellow
> 3 green
> 4 blue



**중간에 빠져나가기**

```python
for i in range(10):
    if i > 5:
        break

    print(i, end=' ')
```

> 0 1 2 3 4 5 



**continue**

**이후 구문은 실행 하지 않고 처음으로 이동**

```python
for i in range(10):
    if i <= 5:
        continue

    print(i, end=' ')
```

> 6 7 8 9 



### while

```python
count = 1
while count < 11:
    print(count, end=' ')
    count += 1
else:
    print('')
```

> 1 2 3 4 5 6 7 8 9 10 

```python
hap, i = 0, 1
while i <= 10:
    hap += i
    i += 1

print( '합: {0}'.format(hap))
```

> 합: 55

```python
i = 0
while i < 10:
    i += 1
    if i < 5:
        continue
    print(i, end=' ')
    if i > 10:
        break
else:
    print('else block')

print('done')
```

> 5 6 7 8 9 10 else block
> done

```python
i = 0
while True:
    print(i)
    if i > 5:
        break
    i += 1
```

> 0
> 1
> 2
> 3
> 4
> 5
> 6























