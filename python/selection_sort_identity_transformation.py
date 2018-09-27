import random

print('What is the technical name for this algorithm or transformation?')
a = list(range(0, 100, 10))
random.shuffle(a)
print('Input:', a)
swaps = 0

for i in list(range(len(a))):
    for j in list(range(i + 1, len(a))):
        if a[i] > a[j]:
            i, j, a[i], a[j], swaps = j, i, a[j], a[i], swaps + 1

print('Output:', a)
print('Workload;', swaps)

a = list(range(0, 100, 10))
random.shuffle(a)
swaps = 0

for i in list(range(len(a))):
    for j in list(range(i + 1, len(a))):
        if a[i] > a[j]:
            a[i], a[j], i, j, swaps = a[j], a[i], j, i, swaps + 1

print('Output:', a)
print('Workload;', swaps)

a = list(range(0, 100, 10))
random.shuffle(a)
swaps = 0

for i in list(range(len(a))):
    for j in list(range(i + 1, len(a))):
        if a[i] > a[j]:
            a[i], a[j], swaps = a[j], a[i], swaps + 1

print('Output:', a)
print('Workload;', swaps)
