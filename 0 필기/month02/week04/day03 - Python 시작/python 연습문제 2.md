[TOC]

---

# 문제 1

```python
s = '/usr/local/bin/python'
a = s.split('/')

# 문제1. 파이썬 경로명 s = '/usr/local/bin/python' 에서 각각의 디렉토리 경로명을 분리하여 출력하세요.
# --- 1
for i in range(1, len(a)) :
    if i!=len(a)-1:
        print(f'\'{a[i]}\'', end=', ')
    else:
        print(f'\'{a[i]}\'')

# --- 2
for i in range(1, len(a)):
    print(f'\'{a[i]}\'', end='\n' if i==len(a)-1 else ', ')

# --- 3
for i in range(1, len(a)) :
    i!=len(a)-1 and print(f'\'{a[i]}\'', end=', ')
    i==len(a)-1 and print(f'\'{a[i]}\'')


# 문제2. 디렉토리 경로명과 파일명을 분리하여 출력하세요.
dir_name = ''
file_name = ''
# --- 1
for i in range(1, len(a)):
    if i==len(a)-1:
        file_name = a[i]
    else:
        dir_name += '/' + a[i]
print(f'\'{dir_name}\', \'{file_name}\'')
```



# 문제 2

```python
# 문제2. 다음과 같은 텍스트에서 모든 태그를 제외한 텍스트만 출력하세요.
s = """
<html>
    <body style='background-color:#ffff'>
        <h4>Click</h4>
        <a href='http://www.python.org'>Here</a>
        <p>
        	To connect to the most powerful tools in the world.
        </p>
    </body>
</html>"""

# --- 1 : 직접 거르기
result = ''
idx = 0
while True:
    if idx >= len(s): break
    if s[idx] == '<':
        while s[idx] != '>':
            result += ''
            idx += 1
    else:
        result += s[idx]
    idx += 1

print(result)

print('------------------------------------------------------------------------------')

# --- 2 : re 사용
import re
def remove_tag(content):
   cleanr = re.compile('<.*?>')
   cleantext = re.sub(cleanr, '', content)
   return cleantext
print(remove_tag(s))
```



# 문제 3

```python
# 문제3.
s = """
    We encourage everyone to contribute to Python. 
    If you still have questions after reviewing the material
    in this guide, then the Python Mentors group is available 
    to help guide new contributors through the process.
    """

# 1)다음 문자열을 모든 소문자를 대문자로 변환하고, 문자 ',', '.','\n'를 없앤 후에 중복
# 없이 각 단어를 순서대로 출력하세요.
a = [',', '.', '\n', ' ']

result = []
str = ''
for i in range(len(s)):
    if s[i] not in a:
        str += s[i].upper()
    else:
        if str != '':
            result.append(str)
            str = ''
print("\n".join([i for i in sorted(list(set(result)))] ))

print("---------------[2]-----------------")

# 2)각 단어의 빈도수도 함께 출력해 보세요
def check_cnt(str):
    wordAll = s.split(' ')
    result = 0
    for i in wordAll:
        if str in i.upper():
            result += 1
    return result

for i in sorted(list(set(result))):
    print(i, ":", check_cnt(i))
```



# 문제 4

```python
# 문제4
# 반복문을 이용하여 369게임에서 박수를 쳐야 하는 경우의 수를 순서대로 화면에
# 출력해보세요. 1부터 99까지만 실행하세요.

# --- 1
a = ['3', '6', '9']
for i in range(1, 100):
    cnt = 0
    for j in str(i):
        if j in a :
            cnt += 1
    if cnt > 0: print(f'{i} {"짝"*cnt}')

# --- 2
def check369(num):
    x = num // 10
    y = num % 10
    cnt = 0
    if x == 3 or x == 6 or x == 9 :
        cnt += 1
    if y == 3 or y == 6 or y == 9 :
        cnt += 1
    if cnt != 0 : print(f'{num} {"짝"*cnt}')

for num in range(1,100):
    check369(num)
```



# 문제 5

```python
# 문제5.
# 함수 sum 을 만드세요. 이 함수는 임의의 개수의 인수를 받아서 그 합을 계산합니다.
# --- 1
def sum1(*args):
    result = 0
    for i in list(args):
        result += i
    return result
print(sum1(1,2,3,4,5,10))

# --- 2
def sum2(a):
    result = 0
    for i in list(a):
        result += int(i)
    return result
a = list(map(int, input("숫자를 여러개 입력하세요 : ").split()))
print(sum2(a))
```



# 문제 6

```python
# 문제6
# 숨겨진 카드의 수를 맞추는 게임입니다.
# 1-100까지의 임의의 수를 가진 카드를 한 장 숨기고 이 카드의 수를 맞추는 게임입니다.
# 아래의 화면과 같이 카드 속의 수가 57인 경우를 보면 수를 맞추는 사람이 40이라고 입력하면 "더 높게",
# 다시 75이라고 입력하면 "더 낮게" 라는 식으로 범위를 좁혀가며 수를 맞추고 있습니다.
# 게임을 반복하기 위해 y/n이라고 묻고 n인 경우 종료됩니다.
import sys
from random import randint

def start():
    global x, y, a, cnt
    print("수를 결정하였습니다. 맞추어 보세요.")
    a = randint(1, 100)
    x, y = 1, 100
    cnt = 1

def check(i):
    global x, y
    if i > a :
        y = i
        print("더 낮게")
    elif i < a :
        x = i
        print("더 높게")
    else:
        return 1

a = x = y = cnt = 0
start()
while True:
    print(f"{x}-{y}")
    i = int(input(f'{cnt}>> '))
    cnt += 1
    if check(i)==1:
        end = input("!!! 맞았습니다. \n다시하시겠습니까(y/n)>>")
        if end=='y':
            start()
            continue
        elif end == 'n':
            break
        else :
            print("잘못 입력 하셨습니다.")
            break
```
