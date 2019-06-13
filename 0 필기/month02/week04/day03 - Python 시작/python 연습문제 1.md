[TOC]

---

# 문제 1

```python
# 문제1. 키보드로 정수 수치를 입력 받아 그것이 3의 배수인지 판단
import sys

num = input('수를 입력하세요 : ')

# --- 1
if num.isalpha():
    print('#1 정수가 아닙니다.')
elif int(num) % 3 != 0:
    print('#1 3의 배수가 아닙니다.')
else:
    print('#1 3의 배수 입니다.')

# --- 2
if num.isalpha():
    print('#2 정수가 아닙니다.') or sys.exit(1)
int(num) % 3 != 0 and print('#2 3의 배수가 아닙니다.')
int(num) % 3 == 0 and print('#2 3의 배수 입니다.')
```



# 문제 2

```python
# 키보드로 정수 수치를 입력 받아 짝수인지 홀수 인지 판별하는 코드를 작성하세요.
num = input('수를 입력하세요 : ')

if num.isalpha():
    print('정수가 아닙니다.')
else :
    num = int(num)

    # --- 1
    print('짝수' if num % 2 == 0 else '홀수')

    # --- 2
    print('짝수' if num & 0x0001 == 0 else '홀수')
```



# 문제 3

```python
# 문제3. 다음과 같은 출력이 되도록 이중 for~in 문을 사용한 코드를 작성하세요.
for i in range(1, 11):
    print('*'*i)
```



# 문제 4

```python
# 문제4 다음과 같은 출력이 되도록 구구단을 작성하세요. (이중 for~in)
for i in range(1, 10):
    for j in range(1, 10):
        print(f'{j} x {i} = {i*j}', end='\t')
    print()
```



# 문제 5

```python
# 문제5.
# 주어진 리스트 데이터를 이용하여 3의 배수의 개수와 배수의 합을 구하여 출력형태와 같이 출력하세요
a = list(range(1,50))
sum1 = cnt = 0

for i in a:
    if(i%3==0):
        cnt+=1
        sum1+=i

print(f'주어진 리스트에서 3의 배수의 개수 => {cnt}')
print(f'주어진 리스트에서 3의 배수의 합 => {sum1}')
```



# 문제 6

```python
# 문제6.
# 키보드에서 정수로 된 돈의 액수를 입력 받아
# 오만 원권, 만원 권, 오천 원권, 천원 권, 500원짜리 동전, 100원짜리 동전,
# 50원짜리 동전, 10원짜리 동전, 1원짜리 동전 각 몇 개로 변환 되는지 작성하시오.

a = int(input('금액 : '))
b = [50000, 10000, 5000, 1000, 500, 100, 50, 10, 5, 1]

# --- 1
for i in b:
    if a >= i :
        cnt = 0
        while a >= i :
            a -= i
            cnt += 1
        print(f'{i}원 : {cnt}개')
```



# 문제 7

```python
# 문제 7.
# 키보드에서 5개의 정수를 입력 받아 리스트에 저장하고 평균을 구하는 프로그램을 작성하시오

# --- 1
a = []
for _ in range(5):
    a.append(int(input('> ')))
print(round(sum(a)/len(a),1))

# --- 2
result = 0
for _ in range(5):
    result += int(input('> '))
print(round(result/5, 1))
```



# 문제 8

```python
# 문제8.
# 문자열을 입력 받아, 해당 문자열을 문자 순서를 뒤집어서 반환하는 함수 reverse(s)을 작성하세요.
a = input('입력> ')

# --- 1
def reverse1(s):
    return s[::-1]
print(f'결과> {reverse1(a)}')

# --- 2
def reverse2(s):
    result = ''
    for i in range(len(s)-1, -1, -1):
        result += s[i]
    return result

print(f'결과> {reverse2(a)}')

# --- 3
reverse3 = lambda x : x[::-1]
print(f'결과> {reverse3(a)}')
```



# 문제 9

```python
# 문제9.
# 주어진 if 문을 dict를 사용해서 수정하세요.

menu = input('메뉴: ')
menupan = {'오뎅' : 300, '순대' : 400, '만두' : 500}

print(f'가격 : {menupan[menu] if menu in menupan else 0}')
```



# 문제 10

```python
'''
문제10
숫자를 입력 받아서 아래와 같은 실행결과가 나타나도록 코드를 완성하세요.
a. 입력 받은 숫자가 홀수인 경우에는, 0 부터 입력 값까지 홀수의 합을 출력합니다.
- 예제 : 입력이 7 이면 16을 출력 ( 1 + 3 + 5 + 7 = 16 )
b. 입력 받은 숫자가 짝수인 경우에는, 0 부터 입력 값까지 짝수의 합을 출력합니다.
    - 예제 : 입력이 10 이면 30을 출력 ( 2 + 4 + 6 + 8 + 10 = 30 )
'''

# --- 1
num = int(input('숫자를 입력하세요 : '))
result = 0
if num % 2 == 0:
    for i in range(num+1):
        if i % 2 == 0 : result += i
else :
    for i in range(num+1):
        if i % 2 == 1 : result += i

print(f'#1 결과 값 : {result}')

# --- 2
def sum1(x):
    result = 0
    for i in range(num+1):
        if i % 2 == x : result += i
    return result

print(f'#2 결과 값 : {sum1(0) if num % 2 == 0 else sum1(1)}')


# --- 3
s = 0
for n in range(num+1):
    if num & 0x0001 ^ n & 0x0001 == 0:
        s += n
print(f'#3 결과 값 : {s}')
```
