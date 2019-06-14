[TOC]

---

# range

```python
seq = range(10)
print(seq, type(seq))
print(list(seq[5:]))
print(len(seq))

for i in seq:
    print(i, end = ' ')
else:
    print()

seq2 = range(5, 16, 5)
for i in seq2:
    print(i, end = ' ')
else:
    print()

seq3 = range(0, -10, -1)
for i in seq3:
    print(i, end = ' ')
else: print()
```

> range(0, 10) <class 'range'>
> [5, 6, 7, 8, 9]
> 10
> 0 1 2 3 4 5 6 7 8 9 
> 5 10 15 
> 0 -1 -2 -3 -4 -5 -6 -7 -8 -9 



# enumerate

```python
i = 0
for value in ['red', 'yellow', 'blue', 'white', 'gray']:
    print('{0}: {1}'.format(i, value))
    i += 1

print("------------------------")
# 비교 : enumerate 함수를  사용했을  때
for i, value in enumerate(['red', 'yellow', 'blue', 'white', 'gray']):
    print('{0}: {1}'.format(i, value))
```

> 0: red
> 1: yellow
> 2: blue
> 3: white
> 4: gray
>
> `---------------------------------------`
>
> 0: red
> 1: yellow
> 2: blue
> 3: white
> 4: gray



# zip

```python
# set 은 순서 X
# seq1 = {'foo', 'bar', 'baz'}
# seq2 = {'one', 'two', 'three'}

# list 순서 ㅇㅇ
seq1 = ['foo', 'bar', 'baz']
seq2 = ['one', 'two', 'three']
z = zip(seq1, seq2)
print(z)
print(type(z))

print(' -------------------------------- ')

for t in z:
    print(t, type(t))

print(' -------------------------------- ')

z = zip(seq1, seq2)

for idx, (a, b) in enumerate(z):
    print('%d: %s, %s' % (idx, a, b))

print(' -------------------------------- ')

d1 = [('foo', 'one'), ('bar', 'two'), ('baz', 'three')]

seq1, seq2 = zip(*d1)
print(seq1)
print(seq2)


```

> ```
> <zip object at 0x000001F2E9E96588>
> <class 'zip'>
>  -------------------------------- 
> ('foo', 'one') <class 'tuple'>
> ('bar', 'two') <class 'tuple'>
> ('baz', 'three') <class 'tuple'>
>  -------------------------------- 
> 0: foo, three
> 1: bar, one
> 2: baz, two
>  -------------------------------- 
> ('foo', 'bar', 'baz')
> ('one', 'two', 'three')
> ```



---



# list conprehension

```python
print('-------------- 기본 ------------------')
results = []
for i in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]:
    result = i * i
    results.append(result)
print(results)

results = [result*result for result in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]]
print(results)

print('------------ if -------------------')

strings = ['a', 'as', 'bat', 'car', 'dove', 'python']
strings = [s for s in strings if len(s) <= 2]
print(strings)

print('---------------- 짝수 list -----------------')

evens = [i for i in range(1, 101) if i % 2 == 0]
print(evens)

print('----------------3 6 9 list-----------------')

gugudan = [(i, '짝'*(str(i).count('3')+str(i).count('6')+str(i).count('9'))) for i in range(1, 101) if str(i).count('3') != 0 or str(i).count('6') != 0 or str(i).count('9') != 0]
print(gugudan)

print('-------------- set -----------------')

strings = ['a', 'as', 'bat', 'car', 'dove', 'python']
lens = [len(s) for s in strings]
print(lens)

lens = {len(s) for s in strings}
print(lens)

print('--------------- dict -----------------')
strings = ['a', 'as', 'bat', 'car', 'dove', 'python']
dicts = {s: len(s) for s in strings}
print(dicts)

```

> ```
> -------------- 기본 ------------------
> [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
> [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
> ------------ if -------------------
> ['a', 'as']
> ---------------- 짝수 list -----------------
> [2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98, 100]
> ----------------3 6 9 list-----------------
> [(3, '짝'), (6, '짝'), (9, '짝'), (13, '짝'), (16, '짝'), (19, '짝'), (23, '짝'), (26, '짝'), (29, '짝'), (30, '짝'), (31, '짝'), (32, '짝'), (33, '짝짝'), (34, '짝'), (35, '짝'), (36, '짝짝'), (37, '짝'), (38, '짝'), (39, '짝짝'), (43, '짝'), (46, '짝'), (49, '짝'), (53, '짝'), (56, '짝'), (59, '짝'), (60, '짝'), (61, '짝'), (62, '짝'), (63, '짝짝'), (64, '짝'), (65, '짝'), (66, '짝짝'), (67, '짝'), (68, '짝'), (69, '짝짝'), (73, '짝'), (76, '짝'), (79, '짝'), (83, '짝'), (86, '짝'), (89, '짝'), (90, '짝'), (91, '짝'), (92, '짝'), (93, '짝짝'), (94, '짝'), (95, '짝'), (96, '짝짝'), (97, '짝'), (98, '짝'), (99, '짝짝')]
> 
> -------------- set -----------------
> [1, 2, 3, 3, 4, 6]
> {1, 2, 3, 4, 6}
> --------------- dict -----------------
> {'a': 1, 'as': 2, 'bat': 3, 'car': 3, 'dove': 4, 'python': 6}
> ```



