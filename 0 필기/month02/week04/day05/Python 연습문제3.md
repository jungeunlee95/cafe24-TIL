[TOC]

---

# 1번

```python
'''
문제 1
다음 세 개의 리스트가 있을 때,
subs = [‘I’, ‘You’]
verbs = [‘Play’, ‘Love’]
objs = [‘Hockey’, ‘Football’]

3형식 문장을 모두 출력해 보세요. 반드시 comprehension을 사용합니다.
'''
subs = ['I', 'You']
verbs = ['Play', 'Love']
objs = ['Hockey', 'Football']

# --- 1
sen = [f'{sub} {verb} {obj}' for sub in subs for verb in verbs for obj in objs]
print('\n'.join(sen))
print('--------------------')

# --- 2
print('\n'.join([f'{sub} {verb} {obj}' for sub in subs for verb in verbs for obj in objs]))

# --- 3
print('--------------------')
for i in subs:
    for j in verbs:
        for k in objs:
            print(i, j, k)
```



# 2번

```python
'''
range() 함수와 유사한 frange() 함수를 작성해 보세요.
frange() 함수는 실수 리스트를 반환합니다.
'''

# --- 1
def frange(val, start=0.0, step=0.1):
    if(val<start):
        val, start = start, val
    i = start
    result = []
    while True:
        if i >= val:
            break
        result.append(round(i,2))
        i += step
    return result


print(frange(2))
print(frange(1.0, 2.0))
print(frange(1.0, 3.0, 0.5))
```



# 3번

```python
'''
문제 3
중첩 루프를 이용해 신문 배달을 하는 프로그램을 작성하세요.
단, 아래에서 arrears 리스트는 신문 구독료가 미납된 세대에 대한 정보를 포함하고 있는데,
해당 세대에는 신문을 배달하지 않아야 합니다.

apart = [[101, 102, 103, 104],
        [201, 202, 203, 204],
        [301, 302, 303, 304],
        [401, 402, 403, 404]]

arrears = [101, 203, 301, 404]
'''
apart = [[101, 102, 103, 104],
         [201, 202, 203, 204],
         [301, 302, 303, 304],
         [401, 402, 403, 404]]

arrears = [101, 203, 301, 404]

# --- 1 : list comprehension
result = [str(i[j]) for i in apart for j in range(len(i)) if i[j] not in arrears]
for i in result:
    print('Newspaper delivery:' + i)

# --- 2 : for
print('------------------------------------')
for i in apart:
    for j in range(len(i)):
        if i[j] not in arrears:
            print(f'Newspaper delivery: {i[j]}')
```



# 4번

```python
'''
구구단 중에 특정 곱셈을 만들고 그 답을 선택하는 프로그램을 작성하는 문제입니다.
답을 포함하여 9개의 정수가 아래와 같은 형태로 출력되고 사용자는 답을 골라 입력하게 됩니다.
프로그램은 정답 여부를 다시 출력합니다.
'''
import random
import sys

# random 숫자 뽑기
a = random.randint(2,9)
b = random.randint(2,9)

print(f'{a} x {b} = ?\n')

# random list만들고 섞기
result = [str(random.randint(2,9)* random.randint(2,9)) for _ in range(8)] + [str(a*b)]
random.shuffle(result)

# 9개의 보기 출력
for i in range(len(result)):
    print(result[i], end='\t')
    if i ==2 or i == 5 or i == 8 :
        print()

# 정답 입력받기
answer = input('\nanswer : ')

# 문자입력하면 ㅃㅃ
if answer.isdigit() == False:
    print("숫자를 입력해주세요!")
    sys.exit(1)

# 정답인가
if int(answer) == a*b:
    print("\n정답")
else: print("\n오답")
```



# 5번

```python
'''
문제5.
선택정렬(제자리 정렬 알고리즘)을 적용하는 코드를 완성하세요.
문제에 주어진 배열 [ 5, 9, 3, 8, 60, 20, 1 ] 를 크기 순서대로 정렬하여
다음과 같은 출력이 되도록 완성하는 문제입니다.

'''

a = [5, 9, 3, 8, 60, 20, 1]

# --- 1 : 그냥 정렬
print(f'Before sort \n{" ".join(map(str,a))}')
for i in range(len(a)):
    for j in range(i+1, len(a)-1):
        if a[i] < a[j]:
            a[i], a[j] = a[j], a[i]
print(f'After sort \n{" ".join(map(str,a))}')


# --- 2 : lambda
print('-------------------------------------')
a = [5, 9, 3, 8, 60, 20, 1]
print(f'Before sort \n{" ".join(map(str,a))}')

def bubblesort(a):
    for i in range(len(a)-1):
        for j in range(len(a)-i-1):
            a[j], a[j + 1] \
                = (lambda x, y: [x, y] if x > y else [y, x]) (a[j], a[j + 1])
    return a
print(f'After sort \n{" ".join(map(str,bubblesort(a)))}')
```

